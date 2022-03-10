import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controlls/login_controller.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator() => Navigator(
      key: CoreRoutes.instance.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute:
          LoginController.name == 'admin' ? dashboardPageRoute : homePageRoute,
    );
