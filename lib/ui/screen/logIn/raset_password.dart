
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utlis/urls.dart';
import '../../../style_file/style.dart';
import '../../widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email , otp;
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();

  bool _setPassInProgress = false;

  Future<void> resetPassword() async {
    _setPassInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller().postRequest(Urls.recoverResetPass , <String , dynamic>{
      "email":widget.email,
      "OTP": widget.otp,
      "password": _passController.text
    });

    _setPassInProgress = false;
    if (mounted) {setState(() {});}

    if(response.isSuccess){
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Reset Password Successfully')));
        Get.offNamed('/LogIn');
      }
    } else{
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Reset Password  has been failed')));
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
                    children: [
                      Column(
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
                            validator: (String? value) {
                              if ((value?.isEmpty ?? true) || value!.length <= 5) {
                                return 'Enter a password more then 6 latter';
                              }
                            },
                            controller: _passController,
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
                            validator: (String? value) {
                              if ((value?.isEmpty ?? true) || value!.length <= 5) {
                                return 'Enter a your confirm password';
                              } else if( value! != _passController.text){
                                return 'Confirm password dose not match';
                              }
                            },
                            controller: _confirmpassController,
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
                            child: Visibility(
                              visible: _setPassInProgress == false,
                              replacement: const Center(child: CircularProgressIndicator(),),
                              child: ElevatedButton(
                                style: buttonStyle(),
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  resetPassword();
                                },
                                child: const Text('Confirm' ,style: TextStyle(color: Colors.white),),
                              ),
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
                                  Get.offNamed('/LogIn');
                                },
                                child: const Text('Sign In'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
