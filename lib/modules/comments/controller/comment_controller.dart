import 'dart:async';

import 'package:comp1640_web/modules/comments/DA/comment_data.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final commentTextController = TextEditingController();
  var loadingSending = ''.obs;

  sendComment(String comment, PostItem post) async {
    loadingSending.value = 'Sending...';
    var rs = await CommentData.createComment(
        title: DateTime.now().toString(),
        content: comment,
        postSlug: post.slug,
        threadSlug: post.thread.slug);
    if (rs.code == 200) {
      commentTextController.clear();
      loadingSending.value = 'Sent';
      Timer(
          const Duration(microseconds: 3000), () => loadingSending.value = '');
    } else {
      loadingSending.value = 'Error send comment. Try again';
    }
  }
}
