import 'package:comp1640_web/helpers/page_404.dart';
import 'package:comp1640_web/pages/admin/admin_home.dart';
import 'package:comp1640_web/pages/admin/thread_manage.dart';
import 'package:comp1640_web/pages/profile.dart';
import 'package:comp1640_web/pages/staff/post_page.dart';
import 'package:flutter/material.dart';

const rootRoute = '/';
const loginPageRoute = '/login';
const logOutDisplayName = 'Log Out';

// Student
const homeDisplayName = 'Ideas';
const homePageRoute = '/home';

const profileDisplayName = 'Profile';
const profilePageRoute = '/profile';

// admin
const dashboardDisplayName = 'DashBoard';
const dashboardPageRoute = '/dash';

const threadDisplayName = 'Thread manage';
const threadPageRoute = '/threadManage';

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> checkRoleShowCategory(role) {
  List<MenuItem> listAction = [];
  switch (role) {
    case 'admin':
      return listAction = [
        MenuItem(homeDisplayName, homePageRoute),
        MenuItem(dashboardDisplayName, dashboardPageRoute),
        MenuItem(threadDisplayName, threadPageRoute),
        MenuItem(profileDisplayName, profilePageRoute),
        MenuItem(logOutDisplayName, loginPageRoute),
      ];
    case 'student':
      return listAction = [
        MenuItem(homeDisplayName, homePageRoute),
        MenuItem(profileDisplayName, profilePageRoute),
        MenuItem(logOutDisplayName, loginPageRoute),
      ];
    default:
      return listAction = [
        MenuItem(homeDisplayName, homePageRoute),
        MenuItem(profileDisplayName, profilePageRoute),
        MenuItem(logOutDisplayName, loginPageRoute),
      ];
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // admin
    case dashboardPageRoute:
      return _getPageRoute(const AdminHome());
    case threadPageRoute:
      return _getPageRoute(const ThreadManage());

    // student
    case homePageRoute:
      return _getPageRoute(const Home());
    case profilePageRoute:
      return _getPageRoute(const Profile());
    default:
      return _getPageRoute(const PageNotFound());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
