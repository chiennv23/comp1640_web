import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget successDialog({
  String title = 'Waiting!!',
  String subTitle = 'Waiting for Admin or Manager approved your thread',
}) =>
    Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        margin: const EdgeInsets.only(left: 16, right: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: successColor,
                  radius: 32,
                  child: Icon(
                    Icons.check,
                    size: 32,
                    color: spaceColor,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 10),
                child: CustomText(
                  text: title,
                  size: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: CustomText(
                    size: 14,
                    maxLine: 2,
                    text: subTitle,
                  ),
                ),
              ),
              Container(
                height: 45,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                          color: successColor,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: Center(
                              child: CustomText(
                                text: 'OK',
                                color: spaceColor,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
