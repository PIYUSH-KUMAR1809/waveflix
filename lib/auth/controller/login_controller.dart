import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waveflix/utils/shared_prefs.dart';

import '../../constants/supabase_client.dart';
import '../../utils/logger.dart';
import '../../widgets/custom_loader.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isObscure = true.obs;
  CustomLoader loader = CustomLoader();

  void updatePasswordStatus() {
    isObscure.value = !isObscure.value;
  }

  //TODO: Setup login functionality
  Future<void> login(BuildContext context) async {
    try {
      loader.showLoader(context);
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email.text,
        password: password.text,
      );
      final Session? session = res.session;
      final User? user = res.user;
      logger.i("Session: $session");
      logger.i("User: $user");
      await saveUserId(user!.id);
      var response = await supabase.storage.listBuckets();
      logger.i(response);
      loader.hideLoader();
      Get.offAllNamed('/home');
    } on AuthException catch (e) {
      loader.hideLoader();
      logger.e("Auth error: $e");
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error Occurred',
        e.message,
        duration: const Duration(seconds: 1),
      );
    }
  }
}
