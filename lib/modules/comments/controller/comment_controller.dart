import 'dart:async';

import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/comments/DA/comment_data.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  PostController postController = Get.find();
  var loadingSending = ''.obs;
  var loading = false.obs;
  var isLoadingAction = false.obs;
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
            sId: rs.data.sId,
            author: rs.data.author,
            content: rs.data.content,
            downvotes: rs.data.downvotes,
            slug: rs.data.slug,
            upvotes: rs.data.upvotes,
            anonymous: rs.data.anonymous,
            oneClickActionCmt: true));
        postController.postListController.refresh();
        checkAnonymous(false);
        loading.value = false;
        changeTextSendCmt('Sent done');
        Future.delayed(const Duration(microseconds: 3000), () {
          changeTextSendCmt('');
        });
      } else {
        changeTextSendCmt('Error send comment. Try again');
        Future.delayed(const Duration(microseconds: 3000), () {
          changeTextSendCmt('');
        });
      }
    } catch (e) {
      print(e);
    } finally {
      changeTextSendCmt('Sent done');
      Future.delayed(const Duration(microseconds: 3000), () {
        changeTextSendCmt('');
      });
    }
  }

  var nameSlug = SharedPreferencesHelper.instance.getString(key: 'nameSlug');

  bool checkLiked(
    String postSlug,
    String cmtSlug,
  ) {
    var listVoteInIdea = postController.postListController
        .firstWhere((element) => element.slug == postSlug)
        .comments
        .firstWhere((element) => element.slug == cmtSlug)
        .upvotes;
    return listVoteInIdea.any((element) => element.slug == nameSlug);
  }

  bool checkDisLiked(
    String postSlug,
      String cmtSlug,
  ) {
    var listVoteInIdea = postController.postListController
        .firstWhere((element) => element.slug == postSlug)
        .comments
        .firstWhere((element) => element.slug == cmtSlug)
        .downvotes;
    return listVoteInIdea.any((element) => element.slug == nameSlug);
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
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .comments
        .firstWhere((e) => e.content == content && e.slug == cmtSlug)
        .upvotes;
    var disListLike = postController.postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .comments
        .firstWhere((e) => e.content == content && e.slug == cmtSlug)
        .downvotes;
    if (listLike.any((element) => element.slug == nameSlug)) {
      listLike.removeWhere((element) => element.slug == nameSlug);
    } else {
      if (disListLike.any((element) => element.slug == nameSlug)) {
        disListLike.removeWhere((element) => element.slug == nameSlug);
      }
      var obj =
          VotesItem(sId: '', email: '', username: '', role: '', slug: nameSlug);
      listLike.add(obj);
    }
    postController.postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .comments
        .firstWhere((e) => e.content == content && e.slug == cmtSlug)
        .oneClickActionCmt = false;
    postController.postListController.refresh();

    final data = await CommentData.likeComment(threadSlug, postSlug, cmtSlug);
    if (data.code != 200) {
      postController.postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .comments
          .firstWhere((e) => e.content == content && e.slug == cmtSlug)
          .oneClickActionCmt = true;
      if (listLike.isNotEmpty) listLike.removeLast();
    } else {
      postController.postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .comments
          .firstWhere((e) => e.content == content && e.slug == cmtSlug)
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
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .comments
        .firstWhere((e) => e.content == content && e.slug == cmtSlug)
        .downvotes;
    var listLike = postController.postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .comments
        .firstWhere((e) => e.content == content && e.slug == cmtSlug)
        .upvotes;
    if (disListLike.any((element) => element.slug == nameSlug)) {
      disListLike.removeWhere((element) => element.slug == nameSlug);
    } else {
      if (listLike.any((element) => element.slug == nameSlug)) {
        listLike.removeWhere((element) => element.slug == nameSlug);
      }
      var obj =
          VotesItem(sId: '', email: '', username: '', role: '', slug: nameSlug);
      disListLike.add(obj);
    }
    print(disListLike.length);
    postController.postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .comments
        .firstWhere((e) => e.content == content && e.slug == cmtSlug)
        .oneClickActionCmt = false;
    postController.postListController.refresh();

    final data =
        await CommentData.disLikeComment(threadSlug, postSlug, cmtSlug);
    if (data.code != 200) {
      postController.postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .comments
          .firstWhere((e) => e.content == content && e.slug == cmtSlug)
          .oneClickActionCmt = true;
      if (disListLike.isNotEmpty) disListLike.removeLast();
    } else {
      postController.postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .comments
          .firstWhere((e) => e.content == content && e.slug == cmtSlug)
          .oneClickActionCmt = false;
    }
  }

  editComment(
      {String threadSlug,
      String postSlug,
      String cmtSlug,
      String content,
      bool anonymous}) async {
    PostController postController = Get.find();
    try {
      changeTextSendCmt('Sending...');
      final data = await CommentData.editComment(threadSlug, postSlug, cmtSlug,
          title: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
          content: content,
          anonymous: anonymous);

      if (data.code == 200) {
        var listCmt = postController.postListController
            .firstWhere((p0) => p0.slug == postSlug)
            .comments;
        var indexCmt = listCmt.indexWhere((element) => element.slug == cmtSlug);
        var newCmt = Comment(
            sId: data.data.sId,
            author: data.data.author,
            content: data.data.content,
            downvotes: data.data.downvotes,
            slug: data.data.slug,
            upvotes: data.data.upvotes,
            anonymous: data.data.anonymous,
            oneClickActionCmt: true);
        listCmt[indexCmt] = newCmt;
        snackBarMessage(
            title: 'Edit successful!', backGroundColor: successColor);
        postController.postListController.refresh();
        Get.back();
      }
    } catch (e) {
      print('edit comment error $e');
    } finally {
      changeTextSendCmt('Sent done');
      Future.delayed(const Duration(microseconds: 3000), () {
        changeTextSendCmt('');
      });
    }
  }

  deleteComment({
    String threadSlug,
    String postSlug,
    String cmtSlug,
  }) async {
    PostController postController = Get.find();
    try {
      isLoadingAction(true);

      final data =
          await CommentData.deleteComment(threadSlug, postSlug, cmtSlug);

      if (data.code == 200) {
        postController.postListController
            .firstWhere((p0) => p0.slug == postSlug)
            .comments
            .removeWhere((element) => element.slug == cmtSlug);
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        postController.postListController.refresh();
        Get.back();
      }
    } catch (e) {
      print('delete comment error $e');
    } finally {
      isLoadingAction(false);
    }
  }
}
