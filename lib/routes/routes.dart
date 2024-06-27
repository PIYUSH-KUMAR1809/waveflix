import 'package:get/get.dart';
import 'package:waveflix/auth/view/login_view.dart';
import 'package:waveflix/auth/view/registration_view.dart';
import 'package:waveflix/home/view/home_screen.dart';
import 'package:waveflix/profile/view/profile_screen.dart';

List<GetPage> get appRoutes => [
      GetPage(
        name: '/login', // This will be the initial route
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/registration',
        page: () => const RegistrationScreen(),
      ),
      GetPage(
        name: '/profile',
        page: () => const ProfileScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => const HomeScreen(),
      ),
    ];
