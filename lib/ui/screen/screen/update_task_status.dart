
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

  List<String> taskStatusList = ['NEW', 'inProgress', 'CANCEL', 'COMPLETED'];

  late String _selectTask;
  bool _updateTaskInProgress = false;

  @override
  void initState() {
    _selectTask = widget.data.status!.toLowerCase();
    super.initState();
  }


  Future<void> updateTask(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    if(mounted){
      setState(() {});
    }

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
            const SnackBar(content: Text('Update task status has been failed')));
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 500,
              child: Visibility(
                visible: _updateTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () {
                    updateTask(widget.data.id!, _selectTask);
                  },
                  child: const Text('Update',style: TextStyle(color: Colors.white,fontSize: 16),),),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
