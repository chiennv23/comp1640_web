import 'package:comp1640_web/widgets/large_screen.dart';
import 'package:comp1640_web/widgets/side_menu.dart';
import 'package:comp1640_web/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/style.dart';
import 'helpers/local_navigator.dart';
import 'helpers/reponsive_pages.dart';
import 'modules/login/controller/user_controller.dart';
import 'modules/threads/controller/thread_controller.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());
    Get.put(ThreadController());

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor.withOpacity(.1),
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
          largeScreen: const LargeScreen(),
          smallScreen: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          )),
    );
  }
}
