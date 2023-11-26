import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/data/models/auth_utility.dart';
import 'package:taskmanager_apps_api/data/models/login_model.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/ui/widgets/screen_background.dart';

import '../../../data/utlis/urls.dart';
import '../../../style_file/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLogINProgress = false;

  Future<void> logIn() async{
    _isLogINProgress = true;
    if(mounted){
      setState(() {});}
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.logIn, <String , dynamic>{
      "email": _emailController.text.trim(),
      "password": _passController.text,
    });

    _isLogINProgress = false;
    if(mounted){setState(() {});}

    if(response.isSuccess){
     LoginModel model = LoginModel.fromJson(response.body ?? '{}');
     await AuthUtility.saveUserInfo(model);

      Get.offNamed('/ButtonNavBar');
    }else{
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Incorrect email or password')));
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 65,),
                  const Text(
                    'Get Started With',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: appInputStyle('Email'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Your Email';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passController,
                    obscureText: isVisible,
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length <= 5) {
                        return 'Enter a password more then 6 latter';
                      }
                    },
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
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible:  _isLogINProgress == false,
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          logIn();
                        },
                        child: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.offNamed('/EmailVerification');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/SignUpScreen');
                        },
                        child: const Text('Sign up'),
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
