import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waveflix/home/models/home_model.dart';
import 'package:waveflix/utils/logger.dart';
import 'package:waveflix/utils/shared_prefs.dart';

import '../../constants/supabase_client.dart';

class HomeController extends GetxController {
  late UserProfile userProfile;
  RxBool isLoading = true.obs;
  Future<void> getData() async {
    String? id = await getUserId();
    if (id == null) {
      Get.offAllNamed('/login');
    } else {
      final response =
          await supabase.from('users').select().eq('uid', id).single();
      logger.i(response);
      userProfile = UserProfile.fromMap(response);
    }
  }

  Future<List<Map<String, String>>> fetchVideoUrls() async {
    final List<FileObject> response =
        await supabase.storage.from('videos').list();
    final videoUrlsAndNames = response.map((file) {
      final url = supabase.storage.from('videos').getPublicUrl(file.name);
      final name = file.name.split('.').first;
      return {'url': url, 'name': name};
    }).toList();
    await getData();
    return videoUrlsAndNames;
  }
  // Future<List<String>> fetchVideoUrls() async {
  //   final List<FileObject> response =
  //       await supabase.storage.from('videos').list();
  //   var response1 = await supabase.storage.listBuckets();
  //   logger.i(response1);
  //   logger.i(response);
  //   final videoUrls = response
  //       .map((file) =>
  //           supabase.storage.from('videos').getPublicUrl('videos/${file.name}'))
  //       .toList();
  //   logger.i(videoUrls);
  //   return videoUrls;
  // }
}
