

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/ui/screen/screen/add_new_task_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/screen/botton_navbar_base.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/email_verification_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/login_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/otp_verification_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/raset_password.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/signup_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/splash_screen.dart';
import 'package:taskmanager_apps_api/ui/screen/screen/update_profile_screen.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
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
        GetPage(name: '/AddNewTaskScreen', page: ()=> const AddNewTaskScreen()),
        GetPage(name: '/UpdateProfileScreen', page: ()=> const UpdateProfileScreen()),
      ],
    );
  }
}