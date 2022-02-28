import 'package:comp1640_web/constant/route/routeString.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/modules/login/views/login.dart';
import 'package:comp1640_web/welcomepage.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

// routes
const rootRoute = '/';
const loginPageRoute = '/login';
const homePageRoute = '/home';
const profilePageRoute = '/profile';
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
      return _getPageRoute(Home());
    case profileDisplayName:
      return _getPageRoute(Home());

    default:
      return _getPageRoute(Home());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is a RegEx match if it is
  /// included inside of the pattern.
  final Widget Function(BuildContext, String) builder;
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static List<Path> paths = [
    Path(
      r'^' + ArticlePage.baseRoute + r'/([\w-]+)$',
      (context, match) => Article.getArticlePage(match),
    ),
    Path(
      r'^' + OverviewPage.route,
      (context, match) => OverviewPage(),
    ),
    Path(
      r'^' + loginPageRoute,
      (context, match) => Login(),
    ),
    Path(
      r'^' + homePageRoute,
      (context, match) => Home(),
    ),
  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final firstMatch = regExpPattern.firstMatch(settings.name);
        final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match),
          settings: settings,
        );
      }
    }
    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}
