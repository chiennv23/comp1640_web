// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome User"),
          SizedBox(
            height: 50,
          ),
          OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                size: 18,
              ),
              label: Text("Logout ")),
        ],
      ))),
    );
  }
}
