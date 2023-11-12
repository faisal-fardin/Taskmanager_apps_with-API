
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../style_file/style.dart';
import '../widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isVisible = true;

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
                    const SizedBox(height: 65,),
                     Text(
                      'Set Password',
                      style: headTextStyle(),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Minimum length password 8  character with \nlatter and number ',
                      style: subTitle(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      obscureText: isVisible,
                      decoration: appInputStyle(
                        'Password',
                        IconButton: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                              isVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: isVisible,
                      decoration: appInputStyle(
                        'Confirm Password',
                        IconButton: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                              isVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () {
                          Get.toNamed('/LogIn');
                        },
                        child: const Text('Confirm'),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
