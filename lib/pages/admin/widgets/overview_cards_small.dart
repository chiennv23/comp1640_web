import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    ThreadController threadController = Get.find();

    return Container(
        height: 400,
        child: Obx(
          () => Column(
            children: [
              InfoCardSmall(
                title: "All Threads",
                value: threadController.isLoading.value
                    ? '...'
                    : "${threadController.ThreadList.length}",
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCardSmall(
                title: "All Posts",
                value: threadController.isLoading.value
                    ? '...'
                    : "${threadController.AllPostInThread}",
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCardSmall(
                title: "All Accounts",
                value: "2",
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCardSmall(
                title: "All",
                value: "32",
              ),
            ],
          ),
        ));
  }
}
