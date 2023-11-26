import 'package:flutter/material.dart';
import 'package:taskmanager_apps_api/ui/widgets/user_profile_banner.dart';

import '../../../style_file/style.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileBanner(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        const Text(
                          'Add New Task',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        TextFormField(
                          controller: _titleController,
                          decoration: appInputStyle('Title'),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter Your Title';
                            }
                          },
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: appInputStyle('Description'),
                          validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter Your Description';
                          }
                        },

                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: buttonStyle(),
                            onPressed: () {

                            },
                            child: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
