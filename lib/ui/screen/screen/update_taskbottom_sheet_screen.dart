import 'package:flutter/material.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/data/utlis/urls.dart';

import '../../../data/models/new_task_status_model.dart';
import '../../../style_file/style.dart';

class UpdateTaskBottomSheet extends StatefulWidget {

  final TaskData data;
  final VoidCallback onUpdate;

  const UpdateTaskBottomSheet({super.key, required this.data, required this.onUpdate});

  @override
  State<UpdateTaskBottomSheet> createState() => _UpdateTaskBottomSheetState();
}

class _UpdateTaskBottomSheetState extends State<UpdateTaskBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _updateTaskInProgress = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.data.title);
    _descriptionController = TextEditingController(text: widget.data.title);
    super.initState();
  }

  Future<void> updateTask()async {
    _updateTaskInProgress = true;
    if(mounted){setState(() {});}

     final NetworkResponse response = await NetworkCaller().postRequest(Urls.newTasks, <String,dynamic>{

     });
    _updateTaskInProgress = false;
    if(mounted){setState(() {});}

    if(response.isSuccess){
      _descriptionController.clear();
      _titleController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task Update successfully'),));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task Update successfully'),));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Update Task',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _updateTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    style: buttonStyle(),
                    onPressed: () {},
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
