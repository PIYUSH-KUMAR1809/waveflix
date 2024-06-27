import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:waveflix/utils/logger.dart';
import 'package:waveflix/video/video_controller.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  VideoPlayerScreen({super.key, required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    logger.i(widget.url);
    // _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play();
    //   });
    videoController.controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.url))
          ..initialize().then((_) {
            setState(() {});
            videoController.isInitialized.value = true;
            videoController.controller.play();
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.controller.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Playing Video'),
          backgroundColor: Colors.blue,
        ),
        body: Obx(
          () => Center(
            child: videoController.isInitialized.value
                ? AspectRatio(
                    aspectRatio: videoController.controller.value.aspectRatio,
                    child: VideoPlayer(videoController.controller),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton(
            onPressed: () {
              videoController.pauseAndPlay();
            },
            child: Icon(
              videoController.isPlaying.value ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }
}
