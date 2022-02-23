import 'package:comp1640_web/constant/route/routeString.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static Future<void> login(
      String userName, String password, BuildContext context) async {
    if (userName.isNotEmpty && password.isNotEmpty) {
      var response = await http.post(Uri.parse("http://reqres.in/api/login"),
          body: ({
            'email': userName,
            'password': password,
          }));
      if (response.statusCode == 200) {
        CoreRoutes.instance.navigateToRouteString(RouteNames.DASHBOARD);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("sai rồi bro")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sai rồi bro")));
    }
  }
}
