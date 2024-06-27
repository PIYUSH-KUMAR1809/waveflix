import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController controller;
  RxBool isPlaying = true.obs;
  RxBool isInitialized = false.obs;

  void pauseAndPlay() {
    if (isPlaying.value) {
      isPlaying.value = !isPlaying.value;
      controller.pause();
    } else {
      isPlaying.value = !isPlaying.value;
      controller.play();
    }
  }
}
