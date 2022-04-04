import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';


AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key,String username) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Container(
              margin: const EdgeInsets.only(left: 15),
              child: Icon(
                Icons.comment,
                color: primaryColor2,
                size: 40,
              ),
            )
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
                text: "Idea System",
                color: darkColor,
                size: 20,
                weight: FontWeight.bold,
              )),
          Expanded(child: Container()),
          // Stack(
          //   children: [
          //     IconButton(
          //         icon: Icon(
          //           Icons.notifications,
          //           color: darkColor.withOpacity(.4),
          //         ),
          //         onPressed: () {}),
          //     Positioned(
          //       top: 7,
          //       right: 7,
          //       child: Container(
          //         width: 12,
          //         height: 12,
          //         padding: const EdgeInsets.all(4),
          //         decoration: BoxDecoration(
          //             color: active,
          //             borderRadius: BorderRadius.circular(30),
          //             border: Border.all(color: lightColor, width: 2)),
          //       ),
          //     )
          //   ],
          // ),
          const SizedBox(
            width: 24,
          ),
          Container(
            width: 1,
            height: 22,
            color: darkColor,
          ),
          const SizedBox(
            width: 24,
          ),
          CustomText(
            text: username ?? '',
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
