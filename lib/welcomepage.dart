import 'package:comp1640_web/constant/route/routeString.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/modules/login/views/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome User"),
          SizedBox(
            height: 50,
          ),
          OutlinedButton.icon(
              onPressed: () {
                CoreRoutes.instance
                    .navigateAndRemoveRouteString(RouteNames.LOGIN);
              },
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
