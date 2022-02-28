import 'package:comp1640_web/constant/route/routeString.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:flutter/material.dart';

import 'constant/route/routes.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome User"),
          SizedBox(
            height: 50,
          ),
        ],
      ))),
    );
  }
}
