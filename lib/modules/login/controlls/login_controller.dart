import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;

class LoginController {

  static Future<void> login(
      String userName, String password, BuildContext context) async {
    // CoreRoutes.instance.navigateToRouteString(homePageRoute);
    Get.offAllNamed(
      rootRoute,
    );
    return;
    var response = await http.post(Uri.parse("http://reqres.in/api/login"),
        body: ({
          'email': userName,
          'password': password,
        }));
    if (response.statusCode == 200) {
      CoreRoutes.instance.navigateToRouteString(homePageRoute);
    } else {
      // snackBarMessage('sai rồi bro');
    }
  }
}
