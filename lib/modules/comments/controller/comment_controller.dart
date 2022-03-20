import 'dart:async';

import 'package:comp1640_web/components/snackbar_messenger.dart';
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

  changeTextSendCmt(String text) => loadingSending.value = text;

  sendComment(String comment, PostItem post, bool anonymous) async {
    try {
      changeTextSendCmt('Sending...');
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
        changeTextSendCmt('Sent done');
        Future.delayed(const Duration(microseconds: 3000), () {
          changeTextSendCmt('');
          print('change send');
        });
      } else {
        changeTextSendCmt('Error send comment. Try again');
        Future.delayed(const Duration(microseconds: 3000), () {
          changeTextSendCmt('');
          print('change send');
        });
      }
    } catch (e) {
      print(e);
    } finally {
      changeTextSendCmt('Sent done');
      Future.delayed(const Duration(microseconds: 3000), () {
        changeTextSendCmt('');
        print('change send');
      });
    }
  }

  chooseLikeCmt(
    String title,
    String content,
    bool checkClickAction, {
    String threadSlug,
    String postSlug,
    String cmtSlug,
  }) async {
    var listLike = postController.postListController
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .upvotes;
    listLike.add('like');
    postController.postListController
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .oneClickActionCmt = false;
    postController.postListController.refresh();

    final data = await CommentData.likeComment(threadSlug, postSlug, cmtSlug);
    if (data.code != 200) {
      postController.postListController
          .firstWhere((element) => element.title == title)
          .comments
          .firstWhere((e) => e.content == content)
          .oneClickActionCmt = true;
      if (listLike.isNotEmpty) listLike.removeLast();
    } else {
      postController.postListController
          .firstWhere((element) => element.title == title)
          .comments
          .firstWhere((e) => e.content == content)
          .oneClickActionCmt = false;
    }
    print(listLike.length);
  }

  chooseDisLikeCmt(
    String title,
    String content,
    bool checkClickAction, {
    String threadSlug,
    String postSlug,
    String cmtSlug,
  }) async {
    var disListLike = postController.postListController
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .downvotes;
    disListLike.add('dislike');
    print(disListLike.length);
    postController.postListController
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .oneClickActionCmt = false;
    postController.postListController.refresh();

    final data =
        await CommentData.disLikeComment(threadSlug, postSlug, cmtSlug);
    if (data.code != 200) {
      postController.postListController
          .firstWhere((element) => element.title == title)
          .comments
          .firstWhere((e) => e.content == content)
          .oneClickActionCmt = true;
      if (disListLike.isNotEmpty) disListLike.removeLast();
    } else {
      postController.postListController
          .firstWhere((element) => element.title == title)
          .comments
          .firstWhere((e) => e.content == content)
          .oneClickActionCmt = false;
    }
  }
}
