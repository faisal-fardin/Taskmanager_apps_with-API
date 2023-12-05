import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager_apps_api/data/models/auth_utility.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/data/utlis/urls.dart';
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

  final userData = AuthUtility.userInfo.data;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    _emailController.text = userData?.email ?? '';
    _firstNameController.text = userData?.firstName ?? '';
    _lastNameController.text = userData?.lastName ?? '';
    _phoneController.text = userData?.mobile ?? '';
    super.initState();
  }

  bool profileInProgress = false;

  Future<void> profileUpdate() async {
    profileInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _phoneController.text.trim(),
      "photo": ""
    };
    if (_passController.text.isEmpty) {
      requestBody['password'] = _passController.text;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    profileInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _passController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Update'),),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Failed'),),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                                    child: Text(
                                      localImagePath?.name ?? 'Photo',
                                      style: const TextStyle(fontSize: 16),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          readOnly: true,
                          decoration: appInputStyle('Email'),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Your Email';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: appInputStyle('First Name'),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Your First Name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: appInputStyle('Last Name'),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Your Last Name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: appInputStyle('Mobile'),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length < 11) {
                              return 'Enter Your Mobile Number';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _passController,
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length <= 5) {
                              return 'Enter a password more then 6 latter';
                            }
                          },
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
                          child: profileInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: buttonStyle(),
                                  onPressed: () {
                                    profileUpdate();
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

  void _getImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then(
      (xFile) {
        if (xFile != null) {
          localImagePath = xFile;
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }
}
