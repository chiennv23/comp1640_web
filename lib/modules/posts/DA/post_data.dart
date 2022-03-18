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
  // static List<PostItem> dataHashCode = [
  //   PostItem(
  //       title: 'title',
  //       content: 'content',
  //       author: Author(email: 'email', sId: 'sid', username: 'usernameAuthor'),
  //       comments: [
  //         CommentItem(
  //             content: 'content',
  //             createdAt: DateTime.now().toString(),
  //             updatedAt: DateTime.now().toString(),
  //             author: Author(
  //                 email: 'email', sId: 'sid', username: 'usernameAuthor'),
  //             downvotes: [
  //               'a',
  //             ],
  //             upvotes: [
  //               '1',
  //               '2'
  //             ])
  //       ],
  //       downvotes: [
  //         'a',
  //       ],
  //       upvotes: ['1', '2'],
  //       category: 'category',
  //       createdAt: DateTime.now().toString(),
  //       updatedAt: DateTime.now().toString(),
  //       thread: 'thread',
  //       slug: 'slug'),
  //   PostItem(
  //       title: 'title2',
  //       content: 'content',
  //       author: Author(email: 'email', sId: 'sid', username: 'usernameAuthor'),
  //       comments: [
  //         CommentItem(
  //             content: 'content',
  //             createdAt: DateTime.now().toString(),
  //             updatedAt: DateTime.now().toString(),
  //             author: Author(
  //                 email: 'email', sId: 'sid', username: 'usernameAuthor'),
  //             downvotes: [
  //               'a',
  //             ],
  //             upvotes: [
  //               '1',
  //               '2'
  //             ])
  //       ],
  //       downvotes: [
  //         'a',
  //       ],
  //       upvotes: ['1', '2'],
  //       category: 'category',
  //       createdAt: DateTime.now().toString(),
  //       updatedAt: DateTime.now().toString(),
  //       thread: 'thread',
  //       slug: 'slug'),
  //   PostItem(
  //       title: 'title3',
  //       content: 'content',
  //       comments: [],
  //       downvotes: [
  //         'a',
  //       ],
  //       upvotes: ['1', '2'],
  //       author: Author(email: 'email', sId: 'sid', username: 'usernameAuthor'),
  //       category: 'category',
  //       createdAt: DateTime.now().toString(),
  //       updatedAt: DateTime.now().toString(),
  //       thread: 'thread',
  //       slug: 'slug'),
  // ];

  static Future<BasicResponse> getAllPostByThread(String threadSlug) async {
    final response = await BaseDA.getList(
        urlGetAllPosts(threadSlug: threadSlug),
        (json) => PostItem.fromJsonToList(json));
    if (response.code == 200) {
      print('List posts done...${response.data.length}');
    }
    return response;
  }

  static ThreadController threadController = Get.find();

  static Future<BasicResponse> createPost(
      String threadSlug, String title, String content, int deadline) async {
    var response = await BaseDA.post(
        urlCreateNewPost(threadSlug),
        {'title': title, 'content': content, 'deadline': deadline},
        (json) => PostItem.fromJson(json));
    if (response.code == 200) {
      print('create post done.');
    } else {
      snackBarMessageError(response.message);
    }
    return response;
  }
}
