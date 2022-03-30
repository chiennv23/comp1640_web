import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class EditThreadManage extends StatefulWidget {
  final ThreadItem item;

  const EditThreadManage({Key key, this.item}) : super(key: key);

  @override
  State<EditThreadManage> createState() => _EditThreadManageState();
}

class _EditThreadManageState extends State<EditThreadManage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;
  int deadlineIdea = DateTime.now().millisecondsSinceEpoch;
  int deadlineComment = DateTime.now().millisecondsSinceEpoch;
  DateTime initDateIdea = DateTime.now();
  DateTime initDateComment = DateTime.now();
  bool checkApprovethread = false;

  @override
  void initState() {
    if (widget.item != null) {
      initDateIdea =
          DateTime.fromMillisecondsSinceEpoch(widget.item.deadlineIdea);
      initDateComment =
          DateTime.fromMillisecondsSinceEpoch(widget.item.deadlineComment);
      deadlineIdea =
          DateTime.fromMillisecondsSinceEpoch(widget.item.deadlineIdea)
              .millisecondsSinceEpoch;
      deadlineComment =
          DateTime.fromMillisecondsSinceEpoch(widget.item.deadlineComment)
              .millisecondsSinceEpoch;
      checkApprovethread = widget.item.approved;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThreadController threadController = Get.find();
    final px = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          width: px.width / 2,
          decoration: BoxDecoration(
              color: spaceColor, borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formGlobalKey,
            autovalidateMode: hasAutoValidation
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                CustomText(
                  text:
                      'Change status ${widget.item.topic} thread of ${widget.item.creator.username}:',
                  size: 20,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Deadline for all ideas:',
                ),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: initDateIdea.toString(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    // if (date.weekday == 6 || date.weekday == 7) {
                    //   return false;
                    // }
                    return true;
                  },
                  onChanged: (val) {
                    setState(() {
                      deadlineIdea =
                          DateTime.tryParse(val).millisecondsSinceEpoch;
                    });
                  },
                  validator: (val) {
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      deadlineIdea =
                          DateTime.tryParse(val).millisecondsSinceEpoch;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'Deadline for all comments:',
                ),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: initDateComment.toString(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    // if (date.weekday == 6 || date.weekday == 7) {
                    //   return false;
                    // }
                    return true;
                  },
                  onChanged: (val) {
                    setState(() {
                      deadlineComment =
                          DateTime.tryParse(val).millisecondsSinceEpoch;
                    });
                  },
                  validator: (val) {
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      deadlineComment =
                          DateTime.tryParse(val).millisecondsSinceEpoch;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Approve for thread: ',
                    ),
                    Checkbox(
                        value: checkApprovethread,
                        onChanged: (value) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            checkApprovethread = value;
                          });
                        }),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          checkApprovethread = !checkApprovethread;
                        });
                      },
                      child: const CustomText(
                        text: "Approve",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: primaryColor2,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () async {
                              setState(() {
                                hasAutoValidation = true;
                              });
                              if (!formGlobalKey.currentState.validate()) {
                                return;
                              }
                              if (widget.item != null) {
                                print(DateTime.fromMillisecondsSinceEpoch(
                                    deadlineIdea));
                                print(DateTime.fromMillisecondsSinceEpoch(
                                    deadlineComment));
                                threadController.editThreadManage(
                                  sid: widget.item.sId,
                                  slug: widget.item.slug,
                                  deadlineIdea: deadlineIdea,
                                  deadlineComment: deadlineComment,
                                  checkApprove: checkApprovethread,
                                );
                                return;
                              }
                            },
                            child: Obx(
                              () => threadController.isLoadingAction.value
                                  ? SpinKitThreeBounce(
                                      color: spaceColor,
                                      size: 25,
                                    )
                                  : Center(
                                      child: CustomText(
                                        text: 'Change',
                                        color: spaceColor,
                                      ),
                                    ),
                            )),
                      ),
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
