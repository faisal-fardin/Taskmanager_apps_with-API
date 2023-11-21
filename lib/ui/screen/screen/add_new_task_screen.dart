import 'package:flutter/material.dart';
import 'package:taskmanager_apps_api/ui/widgets/usere_profile_banner.dart';

import '../../../style_file/style.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
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
                        decoration: appInputStyle('Title'),
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        maxLines: 4,
                        decoration: appInputStyle('Description'),
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
              ],
            ),
          )),
    );
  }
}
