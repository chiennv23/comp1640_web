import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controller/user_controller.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var nameRole = SharedPreferencesHelper.instance.getString(key: 'UserName');

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Obx(() {
      var item = userController.userItem.value;

      return Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 15),
                  child: CustomText(
                    text: menuController.activeItem.value == 'Log Out'
                        ? ''
                        : menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
          Flexible(
            child: ListView(children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'Email',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: item.email,
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'Username',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: item.username,
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'Role',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: item.role,
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'Number of posts created',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: '${item.posts.length} posts created',
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'Number of comments created',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: '${item.comments.length} comments created',
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
              ),
              if (nameRole == 'admin')
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const CustomText(
                    text: 'Number of threads created',
                    size: 16,
                  ),
                  trailing: userController.loading.value
                      ? const Text('...')
                      : CustomText(
                          text: '${item.threads.length} threads created',
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'CreateAt',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: DatetimeConvert.dMy_hm(item.createdAt),
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
              ),
            ]),
          ),
        ],
      );
    });
  }
}
