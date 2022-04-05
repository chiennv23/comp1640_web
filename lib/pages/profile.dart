import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controller/user_controller.dart';
import 'package:comp1640_web/modules/user/view/update_profile.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: active,
                    borderRadius: BorderRadius.circular(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.dialog(UpdateProfile());
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const CustomText(
                          text: "Update profile",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // Material(
                  //   color: active,
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   child: InkWell(
                  //     onTap: () {},
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     child: Container(
                  //       padding: const EdgeInsets.all(10.0),
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8.0)),
                  //       child: const CustomText(
                  //         text: "Delete account",
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const CustomText(
                  text: 'Email',
                  size: 16,
                ),
                trailing: userController.loading.value
                    ? const Text('...')
                    : CustomText(
                        text: userController.userItem.value.email,
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
                        text: userController.userItem.value.username,
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
                        text: userController.userItem.value.role,
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
                        text:
                            '${userController.userItem.value.posts.length} posts created',
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
                        text:
                            '${userController.userItem.value.comments.length} comments created',
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
                          text:
                              '${userController.userItem.value.threads.length} threads created',
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
                        text: DatetimeConvert.dMy_hm(
                            userController.userItem.value.createdAt),
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
