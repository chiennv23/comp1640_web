import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator() => Navigator(
      key: CoreRoutes.instance.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: homePageRoute,
    );
