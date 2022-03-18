import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PostCreate extends StatefulWidget {
  final PostItem item;
  final String threadSlug;

  const PostCreate({Key key, this.item, this.threadSlug}) : super(key: key);

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;
  bool isLoading = false;
  bool checkFile = false;
  int deadline = 0;

  @override
  void initState() {
    if (widget.item != null) {
      titleController.text = widget.item.title;
      contentController.text = widget.item.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    final wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: ResponsiveWidget.isSmallScreen(context) ? wid - 100 : wid / 3,
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
                const CustomText(
                  text: 'Create Idea',
                  size: 20,
                  weight: FontWeight.bold,
                ),
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
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                      labelText: "Content",
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'Deadline',
                ),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
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
                  children: [
                    Material(
                      color: primaryColor2,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            checkFile = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.attach_file,
                                  color: spaceColor,
                                ),
                              ),
                              const CustomText(
                                text: "Attach file",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (checkFile)
                      Expanded(
                          child: CustomText(
                        text: 'example.txt',
                      ))
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
                              isLoading = true;
                            });
                            if (!formGlobalKey.currentState.validate()) {
                              return;
                            }
                            if (widget.item != null) {
                              // postController.editThread(
                              //     sid: widget.item.sId,
                              //     slug: widget.item.slug,
                              //     topic: titleController.text,
                              //     desc: contentController.text);
                              Get.back();
                              return;
                            }
                            postController.createIdea(
                                title: titleController.text,
                                content: contentController.text,
                                threadSlug: widget.threadSlug,
                                deadline: deadline);
                          },
                          child: isLoading
                              ? SpinKitThreeBounce(
                                  color: spaceColor,
                                  size: 25,
                                )
                              : Center(
                                  child: CustomText(
                                    text:
                                        widget.item != null ? 'Edit' : 'Create',
                                    color: spaceColor,
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
