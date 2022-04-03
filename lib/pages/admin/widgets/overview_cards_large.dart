import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/user/controller/user_manage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    ThreadController threadController = Get.find();
    ManageUserController manangeController = Get.find();

    return Obx(
      () => Row(
        children: [
          InfoCard(
            title: "All Threads",
            value: threadController.isLoadingFirst.value
                ? '...'
                : "${threadController.ThreadList.length}",
            topColor: Colors.orange,
          ),
          SizedBox(
            width: _width / 64,
          ),
          InfoCard(
            title: "All Posts",
            value: threadController.isLoadingFirst.value
                ? '...'
                : "${threadController.AllPostInThread}",
            topColor: Colors.lightGreen,
          ),
          SizedBox(
            width: _width / 64,
          ),
          InfoCard(
            title: "All Accounts",
            value: manangeController.isLoadingFirst.value
                ? '...'
                : manangeController.listUserLength.toString(),
            topColor: Colors.redAccent,
          ),
          SizedBox(
            width: _width / 64,
          ),
          InfoCard(
            title: "All",
            value: manangeController.isLoadingFirst.value
                ? '...'
                : "${threadController.ThreadList.length + threadController.AllPostInThread + manangeController.listUserLength}",
          ),
        ],
      ),
    );
  }
}
