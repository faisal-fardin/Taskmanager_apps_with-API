import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../style_file/style.dart';
import '../widgets/screen_background.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 65,
                ),
                Text(
                  'PIN Verification',
                  style: headTextStyle(),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'A 6 digits pin will sent to your email address',
                  style: subTitle(),
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.number,
                  pinTheme: appOTPStyle(),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () {
                      Get.offNamed('/ResetPassword');
                    },
                    child: const Text('Verify'),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/LogIn');
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
