
import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/models/new_task_status_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utlis/urls.dart';
import '../../../style_file/style.dart';

class UpdateTaskStatus extends StatefulWidget {

  final TaskData data;
  final VoidCallback onUpdate;

  const UpdateTaskStatus({super.key, required this.data, required this.onUpdate});
  @override
  State<UpdateTaskStatus> createState() => _UpdateTaskStatusState();
}

class _UpdateTaskStatusState extends State<UpdateTaskStatus> {

  List<String> taskStatusList = ['NEW', 'inProgress', 'CANCEL', 'DELETE'];

  late String _selectTask;
  bool _updateTaskInProgress = false;

  @override
  void initState() {
    _selectTask = widget.data.status!.toLowerCase();
    super.initState();
  }


  Future<void> updateTask(String taskId, String newStatus) async {

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.updateTask(taskId,newStatus));

    _updateTaskInProgress = false;
    if(mounted){
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if(mounted){
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(15),child: Text('Update Status'),),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _selectTask = taskStatusList[index];
                   setState(() {});
                  },
                  title: Text(taskStatusList[index]),
                  trailing: _selectTask == taskStatusList[index]
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
          ),
          SizedBox(
            width: 500,
            child: Visibility(
              replacement: const Center(child: CircularProgressIndicator()),
              child: ElevatedButton(
                style: buttonStyle(),
                onPressed: () {},
                child: const Text('Update'),),
            ),
          ),
        ],
      ),
    );
  }
}
