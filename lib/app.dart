

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/ui/screen/botton_navbar_base.dart';
import 'package:taskmanager_apps_api/ui/screen/email_verification_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/login_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/otp_verification_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/raset_password.dart';
import 'package:taskmanager_apps_api/ui/screen/signup_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
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
        GetPage(name: '/EmailVerification', page: ()=> const EmailVerificationScreen()),
        GetPage(name: '/OtpVerification', page: ()=> const OtpVerificationScreen()),
        GetPage(name: '/ResetPassword', page: ()=> const ResetPasswordScreen()),
        GetPage(name: '/SignUpScreen', page: ()=> const SignUpScreen()),
        GetPage(name: '/ButtonNavBar', page: ()=> const ButtonNavBar()),
      ],
    );
  }
}