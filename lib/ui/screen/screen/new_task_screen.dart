import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/data/models/new_task_status_model.dart';
import 'package:taskmanager_apps_api/data/services/network_caller.dart';
import 'package:taskmanager_apps_api/ui/screen/screen/update_task_status.dart';
import 'package:taskmanager_apps_api/ui/state_managers/summary_count_controller.dart';
import 'package:taskmanager_apps_api/ui/widgets/screen_background.dart';
import '../../../data/utlis/urls.dart';
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
  final NewTaskAddAndSummaryCountController _summaryCountController =
      Get.find<NewTaskAddAndSummaryCountController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary();
      _summaryCountController.getNewTask();
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _summaryCountController.newTaskStatusModel.data!
          .removeWhere((element) => element.id == taskId);
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
        child: ScreenBackground(
          child: Column(
            children: [
              const UserProfileBannerAppBar(),
              GetBuilder<NewTaskAddAndSummaryCountController>(builder: (_) {
                if (_summaryCountController.getCountSummaryInProgress) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _summaryCountController
                              .summaryCountModel.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return SummaryCard(
                          title: _summaryCountController
                                  .summaryCountModel.data![index].id ??
                              'New',
                          number: _summaryCountController
                                  .summaryCountModel.data![index].sum ??
                              0,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                );
              }),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _summaryCountController.getNewTask();
                    _summaryCountController.getCountSummary();
                  },
                  child: GetBuilder<NewTaskAddAndSummaryCountController>(builder: (_) {
                    return ListView.separated(
                      itemCount: _summaryCountController
                              .newTaskStatusModel.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          taskData: _summaryCountController
                              .newTaskStatusModel.data![index],
                          onDeleteTap: () {
                            deleteTask(_summaryCountController
                                .newTaskStatusModel.data![index].id!);
                          },
                          onEditTap: () {
                            // showEditBottomShit(_newTaskStatusModel.data![index]);
                            showUpdateStatusBottomShit(_summaryCountController
                                .newTaskStatusModel.data![index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
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
        return UpdateTaskStatus(
            data: data,
            onUpdate: () {
              _summaryCountController.getNewTask();
            });
      },
    );
  }
}
