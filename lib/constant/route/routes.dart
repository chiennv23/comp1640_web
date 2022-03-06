import 'package:comp1640_web/helpers/page_404.dart';
import 'package:comp1640_web/welcomepage.dart';
import 'package:flutter/material.dart';

// routes
const rootRoute = '/dashboard';
const loginPageRoute = '/login';
const homePageRoute = '$rootRoute/home';
const profilePageRoute = '$rootRoute/profile';
// DisplayName
const logOutDisplayName = 'Log Out';
const homeDisplayName = 'Home';
const profileDisplayName = 'Profile';

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(homeDisplayName, homePageRoute),
  MenuItem(profileDisplayName, profilePageRoute),
  MenuItem(logOutDisplayName, loginPageRoute),
];

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeDisplayName:
      return _getPageRoute(const Home());
    case profileDisplayName:
      return _getPageRoute(const Home());

    default:
      return _getPageRoute(const Home());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
