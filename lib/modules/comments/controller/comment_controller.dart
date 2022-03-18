import 'dart:async';

import 'package:comp1640_web/modules/comments/DA/comment_data.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  PostController postController = Get.find();
  var loadingSending = ''.obs;
  var loading = false.obs;
  var checkAnonymous = false.obs;

  sendComment(String comment, PostItem post, bool anonymous) async {
    loadingSending.value = 'Sending...';
    loading.value = true;
    var rs = await CommentData.createComment(
        title: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
        content: comment,
        anonymous: anonymous,
        postSlug: post.slug,
        threadSlug: post.thread.slug);
    if (rs.code == 200) {
      //TODO add comment in this post
      var indexPost = postController.postListController
          .indexWhere((element) => element.sId == post.sId);
      postController.postListController[indexPost].comments.add(Comment(
          sId: rs.data.id,
          author: rs.data.author,
          content: rs.data.content,
          downvotes: rs.data.downvotes,
          slug: rs.data.slug,
          upvotes: rs.data.upvotes,
          oneClickActionCmt: true));
      postController.postListController.refresh();
      checkAnonymous(false);
      loading.value = false;
      loadingSending('Sent');
      Future.delayed(
          const Duration(microseconds: 3000), () => loadingSending(''));
    } else {
      loadingSending.value = 'Error send comment. Try again';
      Future.delayed(
          const Duration(microseconds: 3000), () => loadingSending(''));
    }
  }
}
