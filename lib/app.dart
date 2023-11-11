

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/ui/screen/login_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> const SplashScreen()),
        GetPage(name: '/LogIn', page: ()=> const LoginScreen()),
      ],
    );
  }
}