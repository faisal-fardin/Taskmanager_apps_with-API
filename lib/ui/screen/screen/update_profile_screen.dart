
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager_apps_api/ui/widgets/screen_background.dart';
import '../../../style_file/style.dart';
import '../../widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isVisible = true;
   XFile? localImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileBannerAppBar(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _getImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                color: Colors.grey,
                                child: const Text(
                                  'Photo',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                               Visibility(
                                visible: localImagePath != null,
                                  child: Text( localImagePath?.name ?? 'Photo', style: TextStyle(fontSize: 16),
                              )),
                            ],
                          ),
                        ),
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
                            icon: Icon(isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
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
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _getImage(ImageSource source) async {
  //   final file =
  //       await ImagePicker().pickImage(source: source, imageQuality: 50);
  //   if (file != null) {
  //     setState(() {
  //       localImagePath = file.path;
  //     });
  //   }
  // }

  void _getImage(){
    ImagePicker().pickImage(source: ImageSource.gallery).then((xFile) {
      if(xFile !=null){
        localImagePath = xFile;
        if(mounted){
          setState(() {});
        }
      }
    },);
  }
}
