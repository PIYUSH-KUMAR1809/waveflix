import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveflix/home/controller/home_controller.dart';
import 'package:waveflix/profile/view/profile_screen.dart';
import 'package:waveflix/utils/shared_prefs.dart';

import '../../video/video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  late Future<List<String>> videoUrls;
  Future<List<Map<String, String>>>? videoUrlsAndNames;

  Future<List<Map<String, String>>> getData() async {
    var response = await homeController.fetchVideoUrls();
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    videoUrlsAndNames = getData();
    homeController.isLoading.value = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WaveFlix'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(ProfileScreen());
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                saveUserId('');
                Get.offAllNamed('/login');
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: FutureBuilder<List<Map<String, String>>>(
          future: videoUrlsAndNames,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No videos found'));
            } else {
              final videos = snapshot.data!;
              return ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(
                        'https://images.indianexpress.com/2024/02/YouTube-YouTube-1.jpg?w=414', // Function to get thumbnail URL
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(video['name']!),
                      onTap: () {
                        Get.to(VideoPlayerScreen(url: video['url']!));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
