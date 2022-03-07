import 'dart:convert';

import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LoginController {
  static Future<BasicResponse> signIn(
    String userName,
    String password,
  ) async {
    var response = await BaseDA.post(
        urlLogin,
        {
          'email': userName,
          'password': password,
        },
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      SharedPreferencesHelper.instance
          .setString(key: 'UserName', val: userName.split('@')[0]);
      print('response.statusCode ' + response.code.toString());
      print('response.mess ' + response.message);
      Get.offAllNamed(
        rootRoute,
      );
      snackBarMessage(
          title: 'Welcome to Feedback System, $userName',
          backGroundColor: Colors.green);
    } else {
      snackBarMessage(
          title: 'Incorrect password or email. Try again!',
          backGroundColor: Colors.red);
    }
    return response;
  }

  static Future<BasicResponse> signUp(
    String email,
    String userName,
    String password,
  ) async {
    var response = await BaseDA.post(
        urlRegister,
        {
          "email": email,
          "username": userName,
          "password": password,
          "confirmPassword": password
        },
        (json) => BasicResponse.fromJson(json));
    print('response.mess ' + response.message);
    if (response.code == 200) {
      SharedPreferencesHelper.instance
          .setString(key: 'UserName', val: userName);
      print('response.statusCode ' + response.code.toString());
      Get.offAllNamed(
        rootRoute,
      );
      snackBarMessage(
          title: 'Welcome to Feedback System, $userName',
          backGroundColor: Colors.green);
    } else {
      snackBarMessage(title: response.message, backGroundColor: Colors.red);
    }
    return response;
  }
}
