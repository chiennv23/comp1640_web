import 'dart:typed_data';

import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
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
      String threadSlug, String title, String content, bool anonymous) async {
    var response = await BaseDA.post(
        urlCreateNewPost(threadSlug),
        {'title': title, 'content': content, 'anonymous': anonymous},
        (json) => PostItem.fromJson(json));
    if (response.code == 200) {
      print('create post done.');
    }
    return response;
  }

  static Future<BasicResponse<PostItem>> createPostFormData(
      {String threadSlug,
      Uint8List bytes,
      String fileName,
      String mimeType,
      String title,
      String content,
      bool anonymous}) async {
    var response = await BaseDA.postFormData(
        url: urlCreateNewPost(threadSlug),
        fileName: fileName,
        bytes: bytes,
        mimeType: mimeType,
        obj: {
          'title': title,
          'content': content,
          'anonymous': anonymous.toString()
        },
        fromJson: (json) => PostItem.fromJson(json));
    if (response.code == 200) {
      print('create post form data done.');
    }
    return response;
  }

  static Future<BasicResponse> editPost(
    String threadSlug,
    String postSlug,
    String title,
    String content,
    bool anonymous,
    Uint8List bytes,
    String fileName,
    String mimeType,
  ) async {
    var response = await BaseDA.putFormData(
        url: urlUpdatePost(threadSlug: threadSlug, postSlug: postSlug),
        fileName: fileName,
        bytes: bytes,
        mimeType: mimeType,
        obj: {
          'title': title,
          'content': content,
          'anonymous': anonymous.toString()
        },
        fromJson: (json) => PostItem.fromJson(json));
    if (response.code == 200) {
      print('Edit post done.');
    }
    return response;
  }

  static Future<BasicResponse> deletePost(
    String threadSlug,
    String postSlug,
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
