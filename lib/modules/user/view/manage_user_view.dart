import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/modules/threads/view/thread_create.dart';
import 'package:comp1640_web/modules/threads/view/thread_delete.dart';
import 'package:comp1640_web/modules/user/model/manageuser_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comp1640_web/modules/user/DA/user_data.dart';
import 'package:comp1640_web/modules/user/controller/user_manage_controller.dart';

Widget UserView(manageuser_item item, String nameSlugLogin,
        {bool checkStaff = false}) =>
    Container(
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: const CustomText(
              text: 'View Infomation of User Account',
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          ListTile(
            title: const CustomText(
              text: "ID",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(
              item.sId ?? '',
              maxLines: 2,
            ),
          ),
          ListTile(
            title: const CustomText(
              text: "Email",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.email ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Username",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.email ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Role",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.role ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Create Time",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(DatetimeConvert.dMy_hm(item.createdAt)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Tooltip(
                //   message: 'Edit',
                //   child: IconButton(
                //       onPressed: () {
                //         if (checkStaff) {
                //           Get.dialog(ThreadCreate(
                //             item: item,
                //           ));
                //           return;
                //         }
                //         Get.dialog(EditThreadManage(
                //           item: item,
                //         ));
                //       },
                //       icon: Icon(
                //         Icons.edit_rounded,
                //         color: primaryColor2,
                //       )),
                // ),
                const SizedBox(
                  width: 15,
                ),
                if (item.slug != nameSlugLogin)
                  Tooltip(
                    message: 'Delete',
                    child: IconButton(
                        onPressed: () {
                          ManageUserController manageController = Get.find();
                          if (checkStaff) {
                            Get.dialog(
                              Center(
                                child: Container(
                                  width: 300,
                                  child: deleteDialog(
                                      deleteOnTap: () {
                                        manageController
                                            .deleteUserofmanage(item.slug);
                                        Get.back();
                                      },
                                      controller: manageController),
                                ),
                              ),
                            );
                            return;
                          }
                          Get.dialog(
                            Center(
                              child: Container(
                                width: 300,
                                child: deleteDialog(
                                    deleteOnTap: () {
                                      manageController
                                          .deleteUserofmanage(item.slug);
                                      Get.back();
                                    },
                                    controller: manageController),
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.delete_rounded,
                          color: primaryColor2,
                        )),
                  ),
                const SizedBox(
                  width: 25,
                ),
                Material(
                  color: primaryColor2,
                  borderRadius: BorderRadius.circular(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const CustomText(
                        text: "Cancel",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
