import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LoginController {
  //TODO chưa thay đổi được khi reload web
  static String name = 'admin';

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
      // await getCsrfToken();
      SharedPreferencesHelper.instance
          .setString(key: 'UserName', val: userName.split('@')[0]);
      print('response.statusCode ' + response.code.toString());
      name = SharedPreferencesHelper.instance.getString(key: 'UserName');
      menuController.changeActiveItemTo(
          checkRoleShowCategory(name)[0].name);
      MenuController.instance.update();
      print(name);
      Get.offAllNamed(
        rootRoute,
      );
      snackBarMessage(
          title: 'Welcome to Feedback System, $userName',
          backGroundColor: Colors.green);
    } else {
      snackBarMessageError(response.message);
    }
    return response;
  }

  static Future<BasicResponse> getCsrfToken() async {
    var res = await BaseDA.get(urlCSRF, (json) => BasicResponse.fromJson(json));
    if (res.code == 200) {
      SharedPreferencesHelper.instance.setString(key: 'csrf', val: res.data);
      print('csrf_token ${res.data}');
    } else {
      snackBarMessageError(res.message);
    }
    return res;
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
      // await getCsrfToken();
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
      snackBarMessageError(response.message);
    }
    return response;
  }
}
