import 'dart:typed_data';

import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class TermAndPolicy extends StatefulWidget {
  final String threadSlug;
  final String title;
  final Uint8List bytes;
  final String fileName;
  final String mimeType;
  final String content;
  final bool anonymous;

  const TermAndPolicy(
      {Key key,
      this.threadSlug,
      this.title,
      this.bytes,
      this.fileName,
      this.mimeType,
      this.content,
      this.anonymous})
      : super(key: key);

  @override
  State<TermAndPolicy> createState() => _TermAndPolicyState();
}

class _TermAndPolicyState extends State<TermAndPolicy> {
  bool checkAgree = false;

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();

    return Container(
      decoration: BoxDecoration(
          color: spaceColor, borderRadius: BorderRadius.circular(12.0)),
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: const CustomText(
              text: 'Terms and Conditions',
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: const Text(
                '1.	You need to make sure that this file of are organized and prepared in the right format(PDF, WORD, EXCEL,….)\n' +
                    '2.	You need to make certain the prepared ideas are matching with the instructions given.\n' +
                    '3.	You need to ensure that the information provided in your papers is completely unique and genuine.\n' +
                    '4.	You need to make sure that ideas are completed and submitted within the deadline.\n' +
                    '5.	You also need to make sure that ideas drafted do not have any quality-related hurdles. \n' +
                    '6.	Your idea will be saved on the website\'s data and the website has the right to use your idea information.\n' +
                    '7. Your ideas will be used and stored in the database, and may be made available to all website users.',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            child: Row(
              children: [
                Checkbox(
                    value: checkAgree,
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        checkAgree = value;
                      });
                    }),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      checkAgree = !checkAgree;
                    });
                  },
                  child: const CustomText(
                    text: "I agree Terms and Conditions",
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                height: 45,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Obx(
                  () => Material(
                    color: checkAgree ? primaryColor2 : greyColor,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: checkAgree
                          ? () async {
                              postController.createIdeaFormData(
                                  threadSlug: widget.threadSlug,
                                  title: widget.title,
                                  content: widget.content,
                                  anonymous: widget.anonymous,
                                  mimeType: widget.mimeType,
                                  bytes: widget.bytes,
                                  fileName: widget.fileName);
                            }
                          : null,
                      child: postController.isLoadingAction.value
                          ? SpinKitThreeBounce(
                              color: spaceColor,
                              size: 25,
                            )
                          : Center(
                              child: CustomText(
                                text: 'Create',
                                color: spaceColor,
                              ),
                            ),
                    ),
                  ),
                ),
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
                      child: const Center(
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
    );
  }
}
