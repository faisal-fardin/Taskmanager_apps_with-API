import 'package:flutter/material.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/data/utlis/urls.dart';
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

  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, <String, dynamic>{
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    });

    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if(response.isSuccess){
      _titleController.clear();
      _descriptionController.clear();
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('New Task added Successfully')));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('New Task added Failed')));
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileBannerAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
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
                    const SizedBox(
                      height: 15,
                    ),
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
                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _addNewTaskInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(

                          style: buttonStyle(),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            addNewTask();
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
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
