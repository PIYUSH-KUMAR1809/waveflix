import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waveflix/constants/supabase_client.dart';
import 'package:waveflix/utils/shared_prefs.dart';
import 'package:waveflix/widgets/custom_loader.dart';

import '../../utils/logger.dart';

class RegistrationController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxString imageURL = ''.obs;
  RxBool isObscurePassword = true.obs;
  RxBool isObscureConfirmPassword = true.obs;
  CustomLoader loader = CustomLoader();

  var selectedImagePath = ''.obs;

  void updatePasswordStatus() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void updateConfirmPasswordStatus() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      logger.i(pickedFile.name);
      selectedImagePath.value = pickedFile.path;
      logger
          .i('Image picked successfully ${selectedImagePath.value.toString()}');
      final imageUrl =
          await uploadImageToSupabase(File(pickedFile.path), pickedFile.name);
      if (imageUrl != null) {
        logger.i('Image uploaded successfully: $imageUrl');
        imageURL.value = imageUrl;
      } else {
        logger.e('Image upload failed');
      }
    } else {
      logger.i('Did not choose image');
      selectedImagePath.value = '';
    }
  }

  // Upload image on Supabase and return URL
  Future<String?> uploadImageToSupabase(
      File imageFile, String imageName) async {
    try {
      final fileName = imageFile.path.split('/').last;

      final response = await supabase.storage.from('user-images').upload(
            imageFile.path,
            imageFile,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
            ),
          );
      logger.i(imageFile.path);
      logger.i(response);
      final publicUrl = Supabase.instance.client.storage
          .from('user-images')
          .getPublicUrl(imageFile.path);
      logger.i(publicUrl);
      return publicUrl;
    } catch (e) {
      logger.e('Upload error: $e');
      return null;
    }
  }

  //TODO: Setup login functionality
  Future<void> registration(BuildContext context) async {
    loader.showLoader(context);
    try {
      final AuthResponse res = await supabase.auth
          .signUp(email: email.text, password: password.text);
      logger.i(res.session);
      logger.i(res.user);
      User user = res.user!;
      await uploadDataToDB(user);
      await saveUserId(user.id);
      var response = await supabase.storage.listBuckets();
      logger.i(response);
      loader.hideLoader();
      Get.offAllNamed('/home');
    } on AuthException catch (authException) {
      logger.i(authException);
      loader.hideLoader();
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error Occurred',
        authException.message,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future<void> uploadDataToDB(User user) async {
    try {
      await Supabase.instance.client.from('users').insert({
        'uid': user.id,
        'name': name.text,
        'email': email.text,
        'phone': phoneNumber.text,
        'image_url': imageURL.value,
      });
    } catch (e) {
      logger.e('User data upload failed: $e');
    }
  }
}
