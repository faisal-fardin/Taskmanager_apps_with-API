import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:taskmanager_apps_api/app.dart';
import 'package:taskmanager_apps_api/data/models/auth_utility.dart';
import 'package:taskmanager_apps_api/data/models/network_response.dart';
import 'package:taskmanager_apps_api/ui/screen/logIn/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(
    String url,
  ) async {
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {'token': AuthUtility.userInfo.token!.toString()},
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtility.userInfo.token!.toString()
        },
        body: jsonEncode(body),
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));

      } else if (response.statusCode == 401) {
        _gotoLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<void> _gotoLogin() async {
    await AuthUtility.clearUserInfo();

    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentState!.context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
