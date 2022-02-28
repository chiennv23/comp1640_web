import 'package:comp1640_web/constant/route/routeString.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/views/login.dart';
import 'package:comp1640_web/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'constant/route/route_navigate.dart';
import 'constant/route/routes.dart';
import 'helpers/menu_controller.dart';
import 'helpers/page_404.dart';
import 'layout.dart';

void main() async {
  setPathUrlStrategy();
  Get.put(MenuController());
  Get.put(CoreRoutes);
  await SharedPreferencesHelper.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: loginPageRoute,
      unknownRoute: GetPage(
          name: '/not-found',
          page: () => PageNotFound(),
          transition: Transition.fadeIn),
      getPages: [
        GetPage(
            name: rootRoute,
            page: () {
              return SiteLayout();
            }),
        GetPage(name: loginPageRoute, page: () => const Login()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Comp1640',
      theme: ThemeData(
        scaffoldBackgroundColor: lightColor,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationPage(),
    );
    return MaterialApp(
      title: 'Comp1640',
      debugShowCheckedModeBanner: false,
      navigatorKey: CoreRoutes.instance.navigatorKey,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
      initialRoute: Login.route,
      theme: ThemeData(
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// In a real application this would probably be some kind of database interface.
const List<Article> articles = [
  Article(
    title: 'A very interesting article',
    slug: 'a-very-interesting-article',
  ),
  Article(
    title: 'Newsworthy news',
    slug: 'newsworthy-news',
  ),
  Article(
    title: 'RegEx is cool',
    slug: 'regex-is-cool',
  ),
];

class Article {
  const Article({this.title, this.slug});

  final String title;
  final String slug;

  static Widget getArticlePage(String slug) {
    for (Article article in articles) {
      if (article.slug == slug) {
        return ArticlePage(article: article);
      }
    }
    return UnknownArticle();
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key key, this.article}) : super(key: key);

  static const String baseRoute = '/article';
  static String Function(String slug) routeFromSlug =
      (String slug) => baseRoute + '/$slug';

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(article.title),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown article'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unknown article'),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  static const String route = '/overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Article article in articles)
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ArticlePage.routeFromSlug(article.slug),
                  );
                },
                child: Text(article.title),
              ),
            RaisedButton(
              onPressed: () {
                // Navigate back to the home screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   static const String route = '/';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Overview page'),
//           onPressed: () {
//             // Navigate to the overview page using a named route.
//             Navigator.pushNamed(context, OverviewPage.route);
//           },
//         ),
//       ),
//     );
//   }
// }
