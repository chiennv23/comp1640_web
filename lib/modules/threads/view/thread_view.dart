import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/modules/threads/view/thread_create.dart';
import 'package:comp1640_web/modules/threads/view/thread_delete.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_thread_manage.dart';

Widget ThreadView(ThreadItem item, {bool checkStaff = false,bool checkEdit = true,}) => Container(
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: CustomText(
              text: 'View ${item.topic} thread:',
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          ListTile(
            title: const CustomText(
              text: "Topic",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(
              item.topic ?? '',
              maxLines: 2,
            ),
          ),
          ListTile(
            title: const CustomText(
              text: "Description",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.description ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Creator",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.creator.email ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Slug",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.slug ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Posts",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.posts.length.toString()),
          ),
          ListTile(
            title: const CustomText(
              text: "Create Date",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(DatetimeConvert.dMy_hm(item.createdAt)),
          ),
          ListTile(
            title: const CustomText(
              text: "Expiration ideas date",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(DatetimeConvert.dMy_hm(item.deadlineIdea)),
          ),
          ListTile(
            title: const CustomText(
              text: "Expiration comments date",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(DatetimeConvert.dMy_hm(item.deadlineComment)),
          ),
          ListTile(
            title: const CustomText(
              text: "Status",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: CustomText(
              text: item.approved ? 'Approved' : 'Not yet',
              color: item.approved ? successColor : orangeColor,
              weight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                if(checkEdit)
                Tooltip(
                  message: 'Edit',
                  child: IconButton(
                      onPressed: () {
                        if (checkStaff) {
                          Get.dialog(ThreadCreate(
                            item: item,
                          ));
                          return;
                        }
                        Get.dialog(EditThreadManage(
                          item: item,
                        ));
                      },
                      icon: Icon(
                        Icons.edit_rounded,
                        color: primaryColor2,
                      )),
                ),
                const SizedBox(
                  width: 15,
                ),
                Tooltip(
                  message: 'Delete',
                  child: IconButton(
                      onPressed: () {
                        ThreadController threadController = Get.find();
                        if (checkStaff) {
                          Get.dialog(
                            Center(
                              child: Container(
                                width: 300,
                                child: deleteDialog(
                                    deleteOnTap: () {
                                      threadController.deleteThread(item.slug);
                                      Get.back();
                                    },
                                    controller: threadController),
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
                                    threadController
                                        .deleteThreadManage(item.slug);
                                    Get.back();
                                  },
                                  controller: threadController),
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
