import 'package:flutter/material.dart';
import 'package:taskmanager_apps_api/data/models/new_task_status_model.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utlis/urls.dart';
import '../../widgets/list_tile_item.dart';
import '../../widgets/user_profile_banner.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  bool _getProgressTaskInprogress = false;
  NewTaskStatusModel _newTaskStatusModel = NewTaskStatusModel();

  Future<void> getInProgressTasks() async {
    _getProgressTaskInprogress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTask);

    if (response.isSuccess) {
      _newTaskStatusModel = NewTaskStatusModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('In Progress  tasks got failed')));
      }
    }
    _getProgressTaskInprogress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInProgressTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBannerAppBar(),
            Expanded(
              child: _getProgressTaskInprogress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemCount: _newTaskStatusModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          taskData: _newTaskStatusModel.data![index],
                          onDeleteTap: () {},
                          onEditTap: () {},
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
