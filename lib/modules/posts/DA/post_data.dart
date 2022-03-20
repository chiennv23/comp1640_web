import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/comments/models/comment_item.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostData {
  static Future<BasicResponse> getAllPostByThread(String threadSlug) async {
    final response = await BaseDA.getList(
        urlGetAllPosts(threadSlug: threadSlug),
        (json) => PostItem.fromJsonToList(json));
    if (response.code == 200) {
      print('List posts done...${response.data.length}');
    }
    return response;
  }

  static Future<BasicResponse> createPost(
      String threadSlug, String title, String content, int deadline) async {
    var response = await BaseDA.post(
        urlCreateNewPost(threadSlug),
        {'title': title, 'content': content, 'deadline': deadline},
        (json) => PostItem.fromJson(json));
    if (response.code == 200) {
      print('create post done.');
    }
    return response;
  }

  static Future<BasicResponse> editPost(String threadSlug, String postSlug,
      String title, String content, int deadline) async {
    var response = await BaseDA.put(
        urlUpdatePost(threadSlug: threadSlug, postSlug: postSlug),
        {'title': title, 'content': content, 'deadline': deadline},
        (json) => PostItem.fromJson(json));
    if (response.code == 200) {
      print('Edit post done.');
    }
    return response;
  }

  static Future<BasicResponse> deletePost(String threadSlug, String postSlug,
      ) async {
    var response = await BaseDA.delete(
        urlDeletePost(threadSlug: threadSlug, postSlug: postSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('Del post done.');
    }
    return response;
  }

  static Future<BasicResponse> likePost(
      String threadSlug, String postSlug) async {
    var response = await BaseDA.post(
        urlLikePost(threadSlug: threadSlug, postSlug: postSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('like post done.');
    }
    return response;
  }

  static Future<BasicResponse> disLikePost(
      String threadSlug, String postSlug) async {
    var response = await BaseDA.post(
        urlDislikePost(threadSlug: threadSlug, postSlug: postSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('dislike post done.');
    } else {
      snackBarMessageError(response.message);
    }
    return response;
  }
}
