import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:flutter/material.dart';

import '../main.dart';

void snackBarMessage({String title, Color backGroundColor}) {
  ScaffoldMessenger.of(CoreRoutes.instance.navigatorKey.currentState.context)
      .showSnackBar(SnackBar(
    content: Text(title),
    backgroundColor: backGroundColor,
  ));
}
