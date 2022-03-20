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

class ThreadCreate extends StatefulWidget {
  final ThreadItem item;

  const ThreadCreate({Key key, this.item}) : super(key: key);

  @override
  State<ThreadCreate> createState() => _ThreadCreateState();
}

class _ThreadCreateState extends State<ThreadCreate> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;
  int deadline = DateTime.now().millisecondsSinceEpoch;
  DateTime initDate = DateTime.now();

  @override
  void initState() {
    if (widget.item != null) {
      titleController.text = widget.item.topic;
      contentController.text = widget.item.description;
      initDate = DateTime.fromMillisecondsSinceEpoch(widget.item.deadline);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThreadController threadController = Get.find();
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (title) {
                    if (title.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter title';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: contentController,
                  validator: (content) {
                    if (content.trim().isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter content';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Content",
                      hintText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'End time for thread:',
                ),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: initDate.toString(),
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
                      deadline = DateTime.tryParse(val).millisecondsSinceEpoch;
                    });
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
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
                                threadController.editThread(
                                    sid: widget.item.sId,
                                    slug: widget.item.slug,
                                    topic: titleController.text,
                                    desc: contentController.text,
                                    deadline: deadline);
                                return;
                              }
                              threadController.createThread(
                                  title: titleController.text,
                                  content: contentController.text,
                                  deadline: deadline);
                            },
                            child: Obx(
                              () => threadController.isLoadingAction.value
                                  ? SpinKitThreeBounce(
                                      color: spaceColor,
                                      size: 25,
                                    )
                                  : Center(
                                      child: CustomText(
                                        text: widget.item != null
                                            ? 'Edit'
                                            : 'Create',
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
                            child: Center(
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
