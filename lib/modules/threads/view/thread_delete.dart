import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

Widget deleteDialog({Function deleteOnTap, controller}) =>
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
                  backgroundColor: redColor,
                  radius: 32,
                  child: Icon(
                    Icons.close_outlined,
                    size: 32,
                    color: spaceColor,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 10),
                child: const CustomText(
                  text: 'Are you sure?',
                  size: 18,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: const CustomText(
                  size: 14,
                  text: 'Warning: Content can not restore!',
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          height: 45,
                          decoration:
                          BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Obx(() =>
                              Material(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: deleteOnTap,
                                    child: Center(
                                      child: controller.isLoadingAction.value
                                          ? SpinKitThreeBounce(
                                        color: spaceColor,
                                        size: 25,
                                      )
                                          : CustomText(
                                        text: 'Delete',
                                        color: spaceColor,
                                      ),
                                    ),
                                  )),)
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Container(
                        height: 45,
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: Material(
                            color: greyColor.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Get.back();
                              },
                              child:const Center(
                                child: CustomText(
                                  text: 'Cancel',
                                  color: darkColor,
                                ),
                              ),
                            )),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
