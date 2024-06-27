import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:waveflix/Routes/routes.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ezdsmmulsvwgdfllkxmb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6ZHNtbXVsc3Z3Z2RmbGxreG1iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTkzNjYwMjAsImV4cCI6MjAzNDk0MjAyMH0.2x0uNotrpo-t0OAIc-odhvE7Ttv58daVaZw9ZFquasg',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaveFlix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      getPages: appRoutes,
    );
  }
}
