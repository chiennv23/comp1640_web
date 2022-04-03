import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/user/controller/user_manage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    ThreadController threadController = Get.find();
    ManageUserController manangeController = Get.find();

    return Container(
        height: 400,
        child: Obx(
          () => Column(
            children: [
              InfoCardSmall(
                title: "All Threads",
                value: threadController.isLoadingFirst.value
                    ? '...'
                    : "${threadController.ThreadList.length}",
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCardSmall(
                title: "All Posts",
                value: threadController.isLoadingFirst.value
                    ? '...'
                    : "${threadController.AllPostInThread}",
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCardSmall(
                title: "All Accounts",
                value: manangeController.isLoadingFirst.value
                    ? '...'
                    : manangeController.listUserLength.toString(),
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCardSmall(
                title: "All",
                value: manangeController.isLoadingFirst.value
                    ? '...'
                    : "${threadController.ThreadList.length + threadController.AllPostInThread + manangeController.listUserLength}",
              ),
            ],
          ),
        ));
  }
}
