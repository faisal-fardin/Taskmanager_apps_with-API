import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/new_task_status_model.dart';
import '../../data/models/summary_count_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utlis/urls.dart';

class NewTaskAddAndSummaryCountController extends GetxController {

  bool _getCountSummaryInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  bool get getCountSummaryInProgress => _getCountSummaryInProgress;
  SummaryCountModel get summaryCountModel => _summaryCountModel;



  bool _getNewTaskInProgress = false;
  NewTaskStatusModel _newTaskStatusModel = NewTaskStatusModel();
  bool get getNewTaskInProgress => _getNewTaskInProgress;
  NewTaskStatusModel get newTaskStatusModel => _newTaskStatusModel;


  Future<bool> getCountSummary() async {
    _getCountSummaryInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getCountSummaryInProgress = false;
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }


  Future<bool> getNewTask() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _newTaskStatusModel = NewTaskStatusModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }








}