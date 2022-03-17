import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/comments/controller/comment_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateComment extends StatefulWidget {
  final PostItem postItem;

  const CreateComment({Key key, @required this.postItem}) : super(key: key);

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  bool anonymousAuthor = false;

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;

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
          TextFormField(
            controller: commentController.commentTextController,
            validator: (comment) {
              if (comment.isNotEmpty) {
                return null;
              } else {
                return 'Enter a valid comment';
              }
            },
            onFieldSubmitted: (string) {
              setState(() {
                hasAutoValidation = true;
              });
              if (!formGlobalKey.currentState.validate()) {
                return;
              }
              commentController.sendComment(string, widget.postItem);
              setState(() {
                hasAutoValidation = false;
              });
            },
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
                  tooltip: 'Sent comment',
                  onPressed: () {
                    setState(() {
                      hasAutoValidation = true;
                    });
                    if (!formGlobalKey.currentState.validate()) {
                      return;
                    }
                    commentController.sendComment(
                        commentController.commentTextController.text,
                        widget.postItem);
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
          commentController.loadingSending.value == ''
              ? Container()
              : Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
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
                  value: anonymousAuthor,
                  onChanged: (value) {
                    setState(() {
                      anonymousAuthor = value;
                    });
                  }),
              InkWell(
                onTap: () {
                  setState(() {
                    anonymousAuthor = !anonymousAuthor;
                  });
                },
                child: const CustomText(
                  text: "Anonymous comment",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
