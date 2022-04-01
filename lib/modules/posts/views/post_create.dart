import 'dart:io';
import 'dart:typed_data';

import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/DA/post_data.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/utils/DropZoneFile/drop_zone_widget.dart';
import 'package:comp1640_web/utils/DropZoneFile/dropped_file.dart';
import 'package:comp1640_web/utils/DropZoneFile/model/file_drop_item.dart';
import 'package:comp1640_web/utils/pick_file.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PostCreate extends StatefulWidget {
  final PostItem item;
  final String threadSlug;
  final String thread;

  const PostCreate({Key key, this.item, this.threadSlug, this.thread})
      : super(key: key);

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;
  bool checkFile = false;
  bool checkAnonymous = false;
  Uint8List bytesFile;
  FilePickerResult pickRs;

  @override
  void initState() {
    if (widget.item != null) {
      titleController.text = widget.item.title;
      contentController.text = widget.item.content;
      checkAnonymous = widget.item.anonymous;
      if (widget.item.files.isNotEmpty) {
        this.file.name = widget.item.files.first.url.split('/').last;
      }
    }
    super.initState();
  }

  File_Data_Model file;

  bool checkFileFunc(String nameCheck) {
    test(String value) => value.contains(nameCheck);

    return allowFileList.any(test);
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
                CustomText(
                  text:
                      '${(widget.item != null) ? 'Edit' : 'Create'} Idea in ${widget.thread} thread',
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: checkAnonymous,
                        onChanged: (value) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            checkAnonymous = value;
                          });
                        }),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          checkAnonymous = !checkAnonymous;
                        });
                      },
                      child: const CustomText(
                        text: "Anonymous idea",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                (kIsWeb)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 150,
                            child: DropZoneWidget(
                              onDroppedFile: (file) => setState(() {
                                this.file = file;
                                bytesFile = file.bytes;
                              }),
                            ),
                          ),
                          if (file != null &&
                              !checkFileFunc(
                                  file.name.toLowerCase().split('.').last))
                            CustomText(
                              text:
                                  'Only using file type: pdf, docx, doc, png, jpg, jpeg, zip',
                              color: redColor,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (file != null &&
                              checkFileFunc(
                                  file.name.toLowerCase().split('.').last))
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: CustomText(
                                maxLine: 2,
                                text: 'Attachment: ${file.name}',
                              ),
                            ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Material(
                                color: primaryColor2,
                                borderRadius: BorderRadius.circular(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      checkFile = true;
                                    });
                                    await pickFile(onDroppedFile: (rs) {
                                      setState(() {
                                        pickRs = rs;
                                      });
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
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
                                width: 10,
                              ),
                            ],
                          ),
                          if (checkFile)
                            Obx(
                              () => Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: CustomText(
                                  text:
                                      'Attachment: ${postController.fileName.value}',
                                ),
                              ),
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
                      child: Obx(
                        () => Material(
                          color: primaryColor2,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: postController.isLoadingAction.value
                                ? () {}
                                : () async {
                                    setState(() {
                                      hasAutoValidation = true;
                                    });
                                    if (!formGlobalKey.currentState
                                        .validate()) {
                                      return;
                                    }
                                    // if (widget.item != null) {
                                    //   postController.editIdea(
                                    //     title: titleController.text,
                                    //     content: contentController.text,
                                    //     postSlug: widget.item.slug,
                                    //     threadSlug: widget.threadSlug,
                                    //     anonymous: checkAnonymous,
                                    //   );
                                    //   return;
                                    // }
                                    // postController.createIdea(
                                    //   title: titleController.text,
                                    //   content: contentController.text,
                                    //   threadSlug: widget.threadSlug,
                                    //   anonymous: checkAnonymous,
                                    // );
                                    // Uint8List data = pickRs.files.single.bytes;
                                    String fileN;
                                    if (file != null) {
                                      fileN = file.name;
                                    } else {
                                      fileN = '';
                                    }
                                    // print(fileN);
                                    // print(bytesFile);
                                    // print(pickRs.files.single.path);
                                    postController.createIdeaFormData(
                                        threadSlug: widget.threadSlug,
                                        title: titleController.text,
                                        content: contentController.text,
                                        anonymous: checkAnonymous,
                                        mimeType: file.mime,
                                        bytes: bytesFile,
                                        fileName: fileN);
                                    // await PostData.createPostFormData(
                                    //     threadSlug: widget.threadSlug,
                                    //     title: titleController.text,
                                    //     content: contentController.text,
                                    //     anonymous: checkAnonymous,
                                    //     bytes: data,
                                    //     fileName: fileN);
                                  },
                            child: postController.isLoadingAction.value
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
