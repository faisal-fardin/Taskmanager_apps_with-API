import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/ui/utils/assets_utils.dart';
import 'package:taskmanager_apps_api/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateLogIn();
  }


  void navigateLogIn(){
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.offNamed('/LogIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(AssetsUtils.logoSvg, height: 40,),
        ),
      ),
    );
  }
}
