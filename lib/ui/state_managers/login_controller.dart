import 'package:get/get.dart';

import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utlis/urls.dart';

class LoginController extends GetxController {
  bool _isLogINProgress = false;

  bool get isLogINProgress => _isLogINProgress;

  Future<bool> logIn(String email, String password) async {
    _isLogINProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.logIn,
        <String, dynamic>{
          "email": email,
          "password": password,
        },
        isLogin: true);
    _isLogINProgress = false;
    update();

    if (response.isSuccess) {
      await AuthUtility.saveUserInfo(
          LoginModel.fromJson(response.body ?? '{}'));
      return true;
    } else {
      return false;
    }
  }
}
