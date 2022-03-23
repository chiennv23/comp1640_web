import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/comments/controller/comment_controller.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowComment extends StatefulWidget {
  final PostItem postItem;
  final String threadSlug;

  const ShowComment({Key key, this.postItem, this.threadSlug})
      : super(key: key);

  @override
  State<ShowComment> createState() => _ShowCommentState();
}

class _ShowCommentState extends State<ShowComment> {
  var nameSlugLogin =
      SharedPreferencesHelper.instance.getString(key: 'nameSlug');

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.find();
    PostController postController = Get.find();
    return Column(
      children: [
        ...List.generate(widget.postItem.comments.length, (index) {
          var item = widget.postItem.comments[index];
          return Container(
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_circle,
                    color: greyColor,
                    size: 35,
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: (item.author.slug == nameSlugLogin)
                            ? '${item.author.username} (You)'
                            : item.author.username,
                        weight: FontWeight.w600,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: CustomText(
                          text: item.content ?? '',
                          size: 14,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            iconSize: 14,
                            icon: const Icon(
                              Icons.thumb_up,
                              size: 16,
                            ),
                            tooltip: 'Like comment',
                            onPressed: postController
                                    .checkDeadlinePost(widget.postItem.deadline)
                                ? null
                                : item.oneClickActionCmt
                                    ? () {
                                        commentController.chooseLikeCmt(
                                            widget.postItem.title,
                                            item.content,
                                            item.oneClickActionCmt,
                                            threadSlug: widget.threadSlug,
                                            postSlug: widget.postItem.slug,
                                            cmtSlug: item.slug);
                                      }
                                    : null,
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: CustomText(
                                text: '${item.upvotes.length}',
                              )),
                          const SizedBox(
                            width: 24,
                          ),
                          IconButton(
                            iconSize: 14,
                            icon: const Icon(
                              Icons.thumb_down,
                              size: 16,
                            ),
                            tooltip: 'Dislike comment',
                            onPressed: postController
                                    .checkDeadlinePost(widget.postItem.deadline)
                                ? null
                                : item.oneClickActionCmt
                                    ? () {
                                        commentController.chooseDisLikeCmt(
                                            widget.postItem.title,
                                            item.content,
                                            item.oneClickActionCmt,
                                            threadSlug: widget.threadSlug,
                                            postSlug: widget.postItem.slug,
                                            cmtSlug: item.slug);
                                      }
                                    : null,
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 8),
                              child:
                                  CustomText(text: '${item.downvotes.length}')),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
          );
        })
      ],
    );
  }
}
