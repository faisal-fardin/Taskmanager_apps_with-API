
import 'package:flutter/material.dart';
import 'package:taskmanager_apps_api/data/models/new_task_status_model.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.taskData,
  });


  final TaskData taskData;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:  Text(taskData.title ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(taskData.description ?? ''),
          Text(taskData.createdDate ?? ''),
          Row(
            children: [
              Chip(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                label: Text( taskData.status ??  'new', style: const TextStyle(color: Colors.white,),),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever, color: Colors.red,),),
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit, color: Colors.green,),),

            ],
          ),
        ],
      ),
    );
  }
}