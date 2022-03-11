import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bar_chart.dart';

class ThreadSectionSmall extends StatelessWidget {
  ThreadController threadController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: greyColor.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: greyColor, width: .5),
        ),
        child: Column(
          children: [
            Container(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    text: "Thread Chart (Topics and Posts)",
                    size: 20,
                    weight: FontWeight.bold,
                    color: greyColor,
                  ),
                  Container(
                    width: 220,
                    height: 1,
                    color: greyColor,
                  ),
                  Container(
                      height: 330,
                      child: HorizontalBarLabelChart(threadController.ThreadChart)),
                ],
              ),
            ),

            // Container(
            //   height: 260,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Row(
            //         children: [
            //           RevenueInfo(
            //             title: "Toda\'s revenue",
            //             amount: "230",
            //           ),
            //           RevenueInfo(
            //             title: "Last 7 days",
            //             amount: "1,100",
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           RevenueInfo(
            //             title: "Last 30 days",
            //             amount: "3,230",
            //           ),
            //           RevenueInfo(
            //             title: "Last 12 months",
            //             amount: "11,300",
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
