import 'package:comp1640_web/constant/route/routeString.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/modules/login/views/login.dart';
import 'package:comp1640_web/welcomepage.dart';
import 'package:flutter/material.dart';

class Routes extends CoreRoutes {
  factory Routes() => CoreRoutes.instance;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case RouteNames.LOGIN:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case RouteNames.DASHBOARD:
        return MaterialPageRoute(
          builder: (context) => const DashBoard(),
        );

      default:
        return _emptyRoute(settings);
    }
  }

  // ignore: unused_element
  static MaterialPageRoute _emptyRoute(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Center(
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
}
