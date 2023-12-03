import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/models/new_task_status_model.dart';
import 'package:taskmanager_apps_api/data/models/summary_count_model.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/ui/screen/screen/update_task_status.dart';
import '../../../data/utlis/urls.dart';
import '../../../style_file/style.dart';
import '../../widgets/list_tile_item.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/user_profile_banner.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({
    super.key,
  });

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getCountSummaryInProgress = false, _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  NewTaskStatusModel _newTaskStatusModel = NewTaskStatusModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTask();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);

    if (response.isSuccess) {
      _newTaskStatusModel = NewTaskStatusModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Get new task failed')));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _newTaskStatusModel.data!.removeWhere((element) => element.id == taskId);
      setState(() {});
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            _getCountSummaryInProgress
                ? const LinearProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summaryCountModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Expanded(
                              child: SummaryCard(
                            title: _summaryCountModel.data![index].id ?? 'New',
                            number: _summaryCountModel.data![index].sum ?? 0,
                          ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTask();
                },
                child: _getNewTaskInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _newTaskStatusModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            taskData: _newTaskStatusModel.data![index],
                            onDeleteTap: () {
                              deleteTask(_newTaskStatusModel.data![index].id!);
                            },
                            onEditTap: () {
                              // showEditBottomShit(_newTaskStatusModel.data![index]);
                              showUpdateStatusBottomShit(
                                  _newTaskStatusModel.data![index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Get.toNamed('/AddNewTaskScreen');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  // void showEditBottomShit(TaskData data) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return UpdateTaskBottomSheet(
  //         data: data,
  //         onUpdate: () {
  //
  //         },
  //       );
  //     },
  //   );
  // }

  void showUpdateStatusBottomShit(TaskData data) {


    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return UpdateTaskStatus(data: data, onUpdate: (){
          getNewTask();
        });
      },
    );
  }
}
