import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/comments/controller/comment_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateComment extends StatefulWidget {
  final PostItem postItem;
  final Comment commentItem;

  const CreateComment({Key key, @required this.postItem, this.commentItem})
      : super(key: key);

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;
  bool checkAnonymous = false;
  final commentTextController = TextEditingController();

  @override
  void initState() {
    if (widget.commentItem != null) {
      commentTextController.text = widget.commentItem.content;
      checkAnonymous = widget.commentItem.anonymous;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.find();
    return Form(
      key: formGlobalKey,
      autovalidateMode: hasAutoValidation
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.commentItem != null)
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const CustomText(
                text: 'Edit comment:',
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
          TextFormField(
            controller: commentTextController,
            validator: (comment) {
              if (comment.isNotEmpty) {
                return null;
              } else {
                return 'Enter a valid comment';
              }
            },
            onFieldSubmitted: (string) {
              FocusScope.of(context).unfocus();
              setState(() {
                hasAutoValidation = true;
              });
              if (!formGlobalKey.currentState.validate()) {
                return;
              }
              if (widget.commentItem != null) {
                commentController.editComment(
                    threadSlug: widget.postItem.thread.slug,
                    postSlug: widget.postItem.slug,
                    cmtSlug: widget.commentItem.slug,
                    content: commentTextController.text,
                    anonymous: checkAnonymous);
              } else {
                commentController.sendComment(commentTextController.text,
                    widget.postItem, checkAnonymous);
              }

              if (commentController.loading.value) {
                commentTextController.clear();
                checkAnonymous = false;
              }
              setState(() {
                hasAutoValidation = false;
              });
            },
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
                labelText: "Comment",
                hintText: "Typing something",
                suffixIcon: IconButton(
                  iconSize: 14,
                  icon: Icon(
                    Icons.send_rounded,
                    color: active,
                    size: 20,
                  ),
                  tooltip: 'Send comment',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      hasAutoValidation = true;
                    });
                    if (!formGlobalKey.currentState.validate()) {
                      return;
                    }
                    if (widget.commentItem != null) {
                      commentController.editComment(
                          threadSlug: widget.postItem.thread.slug,
                          postSlug: widget.postItem.slug,
                          cmtSlug: widget.commentItem.slug,
                          content: commentTextController.text,
                          anonymous: checkAnonymous);
                    } else {
                      commentController.sendComment(commentTextController.text,
                          widget.postItem, checkAnonymous);
                    }

                    if (commentController.loading.value) {
                      commentTextController.clear();
                      checkAnonymous = false;
                    }
                    setState(() {
                      hasAutoValidation = false;
                    });
                  },
                ),
                focusColor: primaryColor2.withOpacity(.4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor2, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
          Obx(
            () => commentController.loadingSending.value == ''
                ? Container()
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(child: child, opacity: animation);
                    },
                    child: Text(
                      commentController.loadingSending.value,
                      key: ValueKey(commentController.loadingSending.value),
                      style: TextStyle(color: greyColor),
                    ),
                  ),
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
                  text: "Anonymous comment",
                ),
              ),
              const Spacer(),
              if (widget.commentItem != null)
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: CustomText(
                    text: "Cancel",
                    color: active,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
