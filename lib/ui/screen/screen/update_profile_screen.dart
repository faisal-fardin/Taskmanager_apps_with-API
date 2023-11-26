
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../style_file/style.dart';
import '../../widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  bool isVisible = true;
  String? localImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserProfileBanner(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Update Your Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            autofocus: true,
                            focusColor: Colors.grey.shade600,
                            onTap: () {
                              _getImage(ImageSource.gallery);
                            },
                            child: localImagePath == null
                                ? const Icon(
                                    Icons.image_search,
                                    size: 40,
                                  )
                                : Image.file(
                                    File(localImagePath!),
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: appInputStyle('Please Select Image'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: appInputStyle('Email'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: appInputStyle('First Name'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: appInputStyle('Last Name'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: appInputStyle('Mobile'),
                    ),
                    const SizedBox(
                      height: 15,
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
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () {
                          Get.offNamed('/ButtonNavBar');
                        },
                        child: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getImage(ImageSource source) async {
    final file =
    await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (file != null) {
      setState(() {
        localImagePath = file.path;
      });
    }
  }
}


