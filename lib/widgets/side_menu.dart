import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:comp1640_web/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var nameRole = SharedPreferencesHelper.instance.getString(key: 'Role');

    return Container(
      decoration: BoxDecoration(
          color: spaceColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        color: darkColor,
                      ),
                    ),
                    const Flexible(
                      child: CustomText(
                        text: "Category",
                        color: darkColor,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: greyColor.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: checkRoleShowCategory(nameRole)
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () async {
                      if (item.route == loginPageRoute) {
                        print('logout');
                        await SharedPreferencesHelper.instance
                            .removeKey(key: 'accessToken');
                        await SharedPreferencesHelper.instance
                            .removeKey(key: 'refreshToken');
                        await SharedPreferencesHelper.instance
                            .removeKey(key: 'UserName');
                        await SharedPreferencesHelper.instance
                            .removeKey(key: 'Role');
                        await SharedPreferencesHelper.instance
                            .removeKey(key: 'nameSlug');
                        menuController.changeActiveItemTo(
                            checkRoleShowCategory(nameRole)[0].name);
                        print(checkRoleShowCategory(nameRole)[0].name);
                        Get.offAllNamed(loginPageRoute);
                      }
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) {
                          Get.back();
                        }
                        CoreRoutes.instance.navigateToRouteString(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
