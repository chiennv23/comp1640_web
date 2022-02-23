import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
