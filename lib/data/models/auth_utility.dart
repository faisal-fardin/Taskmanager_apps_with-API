
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager_apps_api/data/models/login_model.dart';

class AuthUtility{

  AuthUtility._();

  static LoginModel userInfo = LoginModel();

  static Future<void> saveUserInfo(LoginModel model) async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('user-data', jsonEncode(model.toJson()));
    userInfo  = model;
  }

  static Future<LoginModel> getUserInfo() async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String value = _sharedPreferences.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }

  static Future<bool> checkUserLogin() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    bool  isLogin =  _sharedPreferences.containsKey('user-data');
    if(isLogin){
      userInfo =  await getUserInfo();
    }

    return isLogin;

  }



}