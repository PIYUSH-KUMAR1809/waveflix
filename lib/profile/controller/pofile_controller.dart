import 'package:get/get.dart';
import 'package:waveflix/utils/logger.dart';
import 'package:waveflix/utils/shared_prefs.dart';

import '../../constants/supabase_client.dart';
import '../models/profile_model.dart';

class ProfileController extends GetxController {
  late UserProfile userProfile;
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
}
