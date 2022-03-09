import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/views/login.dart';
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
  Get.put(CoreRoutes());
  await SharedPreferencesHelper.instance.init();
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool checkRemember;

  @override
  void initState() {
    checkRemember =
        SharedPreferencesHelper.instance.getBool(key: 'rememberMe') ?? false;
    print(checkRemember);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      initialRoute: checkRemember ? rootRoute : loginPageRoute,
      defaultTransition: Transition.fade,
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
      title: 'Feedback System',
      theme: ThemeData(
        scaffoldBackgroundColor: lightColor,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      // home: AuthenticationPage(),
    );
  }
}
