import 'dart:convert';

import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/main.dart';
import 'package:flutter/material.dart';

void snackBarMessage(
    {String title, Color backGroundColor}) {
  rootScaffoldMessengerKey.currentState.showSnackBar(SnackBar(
    content: Text(title),
    backgroundColor: backGroundColor,
  ));
}

void snackBarMessageError(String messageResponse) {
  Map<String, dynamic> ms = json.decode(messageResponse);
  snackBarMessage(title: ms['message'], backGroundColor: Colors.red);
}
