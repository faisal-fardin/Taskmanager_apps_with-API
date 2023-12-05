import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/data/utlis/urls.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/otp_verification_screen.dart';

import '../../../style_file/style.dart';
import '../../widgets/screen_background.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _emailVerificationInProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendOTPEmail() async {
    _emailVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOTPEmail(_emailController.text.trim()));
    _emailVerificationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if(mounted){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                  email: _emailController.text.trim(),)));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email Verification has been failed')));
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
                    'Your Email Address',
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
                  TextFormField(
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Your Email';
                      }
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: appInputStyle('Email'),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _emailVerificationInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          sendOTPEmail();
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
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
                          Get.offNamed('/LogIn');
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
