import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controlls/login_controller.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Container()
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                key.currentState.openDrawer();
              }),
      title: Row(
        children: [
          Visibility(
              visible: !ResponsiveWidget.isSmallScreen(context),
              child: const CustomText(
                text: "Feedback System",
                color: darkColor,
                size: 20,
                weight: FontWeight.bold,
              )),
          Expanded(child: Container()),
          Container(
            width: 1,
            height: 22,
            color: darkColor,
          ),
          const SizedBox(
            width: 24,
          ),
          CustomText(
            text: SharedPreferencesHelper.instance.getString(key: 'UserName'),
            color: darkColor,
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: active.withOpacity(.5),
                borderRadius: BorderRadius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: spaceColor,
                child: const Icon(
                  Icons.person_outline,
                  color: darkColor,
                ),
              ),
            ),
          )
        ],
      ),
      iconTheme: const IconThemeData(color: darkColor),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
