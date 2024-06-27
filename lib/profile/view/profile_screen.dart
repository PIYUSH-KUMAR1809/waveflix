import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveflix/profile/controller/pofile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WaveFlix'),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
          future: profileController.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage(
                            profileController.userProfile.imageUrl),
                      ),
                      Text("Name: ${profileController.userProfile.name}"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text("Email: ${profileController.userProfile.email}"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text("Mobile: ${profileController.userProfile.phone}"),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
