import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/data/utlis/urls.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/raset_password.dart';

import '../../../style_file/style.dart';
import '../../widgets/screen_background.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _otpController = TextEditingController();

  bool _otpVerificationInProgress = false;

  Future<void> verifyOTP() async {
    _otpVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.otpVerify(widget.email, _otpController.text));
    _otpVerificationInProgress = false;
    if (mounted) {setState(() {});}

    if(response.isSuccess){
      if(mounted){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  ResetPasswordScreen(email: widget.email, otp: _otpController .text,)));
      }
    } else{
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('OTP Verification has been failed')));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: _formKey,
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
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter 6 digits Pin';
                      }
                    },
                    controller: _otpController,
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
                    child: Visibility(
                      visible: _otpVerificationInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                        verifyOTP();
                        },
                        child: const Text('Verify',style: TextStyle(color: Colors.white),),
                      ),
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
        ),
      )),
    );
  }
}
