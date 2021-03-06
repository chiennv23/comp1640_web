import 'dart:math';
import 'dart:typed_data';

import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/posts/DA/post_data.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/modules/threads/view/create_success.dart';
import 'package:comp1640_web/pages/admin/widgets/circle_chart.dart';
import 'package:comp1640_web/pages/admin/widgets/col_chart.dart';
import 'package:comp1640_web/pages/admin/widgets/line_chart.dart';
import 'package:comp1640_web/utils/pick_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PostController extends GetxController {
  ThreadController threadController = Get.find();

  RxBool isLoadingFirst = false.obs;
  RxBool isLoadingManage = false.obs;
  RxBool isLoadingAction = false.obs;
  RxBool isLoadingChart = false.obs;
  final postListController = <PostItem>[].obs;
  final postListChartController = <PostItem>[].obs;
  final postListManageController = <PostItem>[].obs;
  var fileName = ''.obs;

  @override
  void onInit() {
    callListIntoDA();
    super.onInit();
  }

  Future callListIntoDA() async {
    try {
      isLoadingFirst(true);
      var firstSlug =
          SharedPreferencesHelper.instance.getString(key: 'firstSlug');
      final data = await PostData.getAllPostByThread(
          threadController.slugSelected.value != ''
              ? threadController.slugSelected.value
              : firstSlug);
      if (data.code == 200) {
        postListController.assignAll(data?.data);
      } else {
        snackBarMessageError(data.message);
      }
    } finally {
      isLoadingFirst(false);
    }
  }

  Future callListForChart({String threadSlug}) async {
    try {
      isLoadingChart(true);
      print(threadController.slugChartSelected.value);
      final data = await PostData.getAllPostByThread(
          threadSlug ?? threadController.slugChartSelected.value);
      if (data.code == 200) {
        postListChartController.assignAll(data?.data);
      } else {
        snackBarMessageError(data.message);
      }
    } finally {
      isLoadingChart(false);
    }
  }

  Future callListForManage() async {
    try {
      isLoadingManage(true);
      final data = await PostData.getAllPostByManage();
      if (data.code == 200) {
        postListManageController.assignAll(data?.data);
      } else {
        snackBarMessageError(data.message);
      }
    } finally {
      isLoadingManage(false);
    }
  }

  List<PostItem> sortMostLikeIdeas({String status, int take}) {
    if (status == 'Default') {
      return postListController.take(take).toList();
    } else if (status == 'Popular ideas') {
      return postListController.take(take).toList()
        ..sort((a, b) => b.mostPoint.compareTo(a.mostPoint));
    } else if (status == 'Most like') {
      return postListController.take(take).toList()
        ..sort((a, b) => b.upvotes.length.compareTo(a.upvotes.length));
    } else if (status == 'Most dislike') {
      return postListController.take(take).toList()
        ..sort((a, b) => b.downvotes.length.compareTo(a.downvotes.length));
    } else {
      return postListController.take(take).toList()
        ..sort((a, b) => b.comments.length.compareTo(a.comments.length));
    }
  }

  List<charts.Series<YearValue, String>> yearsAndPostsChart() {
    int getLengthIdeaByYear(int year) {
      return postListManageController
          .where((p0) =>
              DateTime.fromMillisecondsSinceEpoch(p0.createdAt).year ==
              DateTime.fromMillisecondsSinceEpoch(
                          DateTime.now().millisecondsSinceEpoch)
                      .year -
                  year)
          .length;
    }

    final data = [
      YearValue((DateTime.now().year - 3).toString(), getLengthIdeaByYear(3)),
      YearValue((DateTime.now().year - 2).toString(), getLengthIdeaByYear(2)),
      YearValue((DateTime.now().year - 1).toString(), getLengthIdeaByYear(1)),
      YearValue((DateTime.now().year).toString(), getLengthIdeaByYear(0)),
    ];

    return [
      charts.Series<YearValue, String>(
        id: 'Years&Ideas',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (YearValue sales, _) => sales.year,
        measureFn: (YearValue sales, _) => sales.value,
        labelAccessorFn: (YearValue sales, _) =>
            '${sales.value.toString()} ideas',
        data: data,
      )
    ];
  }

  List<charts.Series<LinearDate, DateTime>> lineIdeasCreates() {
    final now = DateTime.now();
    int lastWeek(int value) {
      return DateTime(now.year, now.month, now.day + value)
          .millisecondsSinceEpoch;
    }

    var nDayAgo6 = lastWeek(-6);
    var nDayAgo5 = lastWeek(-5);
    var nDayAgo4 = lastWeek(-4);
    var nDayAgo3 = lastWeek(-3);
    var nDayAgo2 = lastWeek(-2);
    var nDayAgo1 = lastWeek(-1);
    var nDay = lastWeek(-0);

    int getIdeasByDay(int day) {
      var listPostInDay = postListManageController.where((p0) =>
          DateTime.fromMillisecondsSinceEpoch(p0.createdAt)
              .isSameDate(DateTime.fromMillisecondsSinceEpoch(day)));
      return listPostInDay.length;
    }

    final IDeas = [
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo6),
          getIdeasByDay(nDayAgo6)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo5),
          getIdeasByDay(nDayAgo5)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo4),
          getIdeasByDay(nDayAgo4)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo3),
          getIdeasByDay(nDayAgo3)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo2),
          getIdeasByDay(nDayAgo2)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo1),
          getIdeasByDay(nDayAgo1)),
      LinearDate(
          DateTime.fromMillisecondsSinceEpoch(nDay), getIdeasByDay(nDay)),
    ];

    return [
      charts.Series<LinearDate, DateTime>(
        id: 'IdeasByDay',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: IDeas,
      ),
    ];
  }

  List<charts.Series<LinearDate, DateTime>> lineLikeDislikeComment() {
    final now = DateTime.now();
    int lastWeek(int value) {
      return DateTime(now.year, now.month, now.day + value)
          .millisecondsSinceEpoch;
    }

    var nDayAgo6 = lastWeek(-6);
    var nDayAgo5 = lastWeek(-5);
    var nDayAgo4 = lastWeek(-4);
    var nDayAgo3 = lastWeek(-3);
    var nDayAgo2 = lastWeek(-2);
    var nDayAgo1 = lastWeek(-1);
    var nDay = lastWeek(-0);

    int getLikesByDay(int day) {
      var listPostInDay = postListManageController.where((p0) =>
          DateTime.fromMillisecondsSinceEpoch(p0.createdAt)
              .isSameDate(DateTime.fromMillisecondsSinceEpoch(day)));
      int totalLike = 0;
      for (var i in listPostInDay) {
        totalLike += i.upvotes.length;
      }
      return totalLike;
    }

    int getDisLikesByDay(int day) {
      var listPostInDay = postListManageController.where((p0) =>
          DateTime.fromMillisecondsSinceEpoch(p0.createdAt)
              .isSameDate(DateTime.fromMillisecondsSinceEpoch(day)));
      int totalDisLike = 0;
      for (var i in listPostInDay) {
        totalDisLike += i.downvotes.length;
        // print(totalDisLike);
      }
      return totalDisLike;
    }

    int getCommentsByDay(int day) {
      var listPostInDay = postListManageController.where((p0) =>
          DateTime.fromMillisecondsSinceEpoch(p0.createdAt)
              .isSameDate(DateTime.fromMillisecondsSinceEpoch(day)));
      int totalComment = 0;
      for (var i in listPostInDay) {
        totalComment += i.comments.length;
        // print(totalComment);
      }
      return totalComment;
    }

    final likes = [
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo6),
          getLikesByDay(nDayAgo6)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo5),
          getLikesByDay(nDayAgo5)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo4),
          getLikesByDay(nDayAgo4)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo3),
          getLikesByDay(nDayAgo3)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo2),
          getLikesByDay(nDayAgo2)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo1),
          getLikesByDay(nDayAgo1)),
      LinearDate(
          DateTime.fromMillisecondsSinceEpoch(nDay), getLikesByDay(nDay)),
    ];

    var disLikes = [
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo6),
          getDisLikesByDay(nDayAgo6)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo5),
          getDisLikesByDay(nDayAgo5)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo4),
          getDisLikesByDay(nDayAgo4)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo3),
          getDisLikesByDay(nDayAgo3)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo2),
          getDisLikesByDay(nDayAgo2)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo1),
          getDisLikesByDay(nDayAgo1)),
      LinearDate(
          DateTime.fromMillisecondsSinceEpoch(nDay), getDisLikesByDay(nDay)),
    ];

    var comments = [
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo6),
          getCommentsByDay(nDayAgo6)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo5),
          getCommentsByDay(nDayAgo5)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo4),
          getCommentsByDay(nDayAgo4)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo3),
          getCommentsByDay(nDayAgo3)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo2),
          getCommentsByDay(nDayAgo2)),
      LinearDate(DateTime.fromMillisecondsSinceEpoch(nDayAgo1),
          getCommentsByDay(nDayAgo1)),
      LinearDate(
          DateTime.fromMillisecondsSinceEpoch(nDay), getCommentsByDay(nDay)),
    ];

    return [
      charts.Series<LinearDate, DateTime>(
        id: 'Likes',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: likes,
      ),
      charts.Series<LinearDate, DateTime>(
        id: 'Dislikes',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: disLikes,
      ),
      charts.Series<LinearDate, DateTime>(
        id: 'Comments',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearDate sales, _) => sales.day,
        measureFn: (LinearDate sales, _) => sales.value,
        data: comments,
      ),
    ];
  }

  List<charts.Series<PostItem, int>> get commentsAndPostsChart {
    List<PostItem> lt = postListChartController.take(5).toList()
      ..sort((a, b) => b.comments.length.compareTo(a.comments.length));
    return [
      charts.Series<PostItem, int>(
        id: 'Ideas&Comment',
        colorFn: (PostItem postItem, count) {
          var post = postItem.comments.length;
          var postMax = postListChartController
              .take(5)
              .map((m) => m.comments.length)
              .reduce(max);
          if (post == postMax) {
            // max
            return charts.ColorUtil.fromDartColor(primaryColor2);
          } else if (post <= postMax / (1 / 4) && post >= postMax / 2) {
            // medium
            return charts.ColorUtil.fromDartColor(orangeColor);
          } else if (post < postMax / 2) {
            return charts.ColorUtil.fromDartColor(redColor);
          } else {
            return charts.ColorUtil.fromDartColor(redColor);
          }
        },
        domainFn: (PostItem post, _) => post.createdAt,
        measureFn: (PostItem post, _) =>
            post.comments.isEmpty ? 1 : post.comments.length,
        labelAccessorFn: (PostItem post, _) =>
            '${post.title}: ${post.comments.isEmpty ? '0' : post.comments.length.toString()} comments',
        data: lt,
      ),
    ];
  }

  List<PostItem> get postList {
    return [...postListController];
  }

  List<Posts> get topLikePostList {
    ThreadController threadController = Get.find();
    var listThread = [...threadController.ThreadList];
    List<Posts> postL = [];
    for (var i = 0; i < listThread.length; i++) {
      listThread[i]
          .posts
          .sort((a, b) => b.upvotes.length.compareTo(a.upvotes.length));
      for (var post in listThread[i].posts) {
        postL.add(post);
      }
    }
    return postL.take(10).toList();
  }

  List<charts.Series<Posts, String>> get postAndLikesChart {
    return [
      charts.Series<Posts, String>(
        id: 'Ideas&Like',
        colorFn: (Posts postItem, count) {
          var post = postItem.upvotes.length;
          var postMax =
              topLikePostList.map((m) => m.upvotes.length).reduce(max);
          if (post == postMax) {
            // max
            return charts.ColorUtil.fromDartColor(primaryColor2);
          } else if (post <= postMax / (1 / 4) && post >= postMax / 2) {
            // medium
            return charts.ColorUtil.fromDartColor(orangeColor);
          } else if (post < postMax / 2) {
            return charts.ColorUtil.fromDartColor(redColor);
          } else {
            return charts.ColorUtil.fromDartColor(redColor);
          }
        },
        domainFn: (Posts post, _) => post.title,
        measureFn: (Posts post, _) => post.upvotes.length,
        labelAccessorFn: (Posts post, _) =>
            '${post.title}: ${post.upvotes.length.toString()} like',
        data: topLikePostList,
      ),
    ];
  }

  List<Posts> get topDisLikePostList {
    ThreadController threadController = Get.find();
    var listThread = [...threadController.ThreadList];
    List<Posts> postL = [];
    listThread.forEach((thread) {
      thread.posts.sort((a, b) => b.downvotes.length - a.downvotes.length);
      thread.posts.forEach((post) {
        postL.add(post);
      });
    });
    return postL.take(10).toList();
  }

  List<charts.Series<Posts, String>> get postAndDisLikesChart {
    return [
      charts.Series<Posts, String>(
        id: 'Ideas&DisLike',
        colorFn: (Posts postItem, count) {
          var post = postItem.downvotes.length;
          var postMax =
              topLikePostList.map((m) => m.downvotes.length).reduce(max);
          if (post == postMax) {
            // max
            return charts.ColorUtil.fromDartColor(primaryColor2);
          } else if (post <= postMax / (1 / 4) && post >= postMax / 2) {
            // medium
            return charts.ColorUtil.fromDartColor(orangeColor);
          } else if (post < postMax / 2) {
            return charts.ColorUtil.fromDartColor(redColor);
          } else {
            return charts.ColorUtil.fromDartColor(redColor);
          }
        },
        domainFn: (Posts post, _) => post.title,
        measureFn: (Posts post, _) => post.downvotes.length,
        labelAccessorFn: (Posts post, _) =>
            '${post.title}: ${post.downvotes.length.toString()} dislike',
        data: topDisLikePostList,
      ),
    ];
  }

  List<charts.Series> changeChartData(String value) {
    int x = int.parse(value);
    switch (x) {
      case 0:
        return postAndLikesChart;
      case 1:
        return postAndDisLikesChart;
      case 2:
        return threadController.threadAndPostChart;
    }
  }

  bool loadingAction(bool loading) => isLoadingAction.value = loading;

  createIdeaFormData(
      {String threadSlug,
      String title,
      Uint8List bytes,
      String fileName,
      String mimeType,
      String content,
      bool anonymous}) async {
    // try {
    loadingAction(true);
    final data = await PostData.createPostFormData(
        threadSlug: threadSlug,
        title: title,
        content: content,
        mimeType: mimeType,
        anonymous: anonymous,
        bytes: bytes,
        fileName: fileName);
    if (data.code == 200) {
      loadingAction(false);
      postListController.insert(0, data.data);
      await Get.dialog(
        Center(
          child: SizedBox(
            width: 300,
            child: successDialog(
              title: 'Congratulation!',
              subTitle: 'You created successful new idea',
              back: () {
                Get.back();
                Get.back();
                Get.back();
              },
            ),
          ),
        ),
      );
      snackBarMessage(
          title: 'Create idea successful!', backGroundColor: successColor);
      update();
    } else {
      loadingAction(false);
    }
    // } catch (e) {
    //   print('create idea error $e');
    // } finally {
    //   loadingAction(false);
    // }
  }

  editIdea(
      {String threadSlug,
      String postSlug,
      String title,
      Uint8List bytes,
      String fileName,
      String mimeType,
      String content,
      bool anonymous}) async {
    loadingAction(true);
    final data = await PostData.editPost(threadSlug, postSlug, title, content,
        anonymous, bytes, fileName, mimeType);
    if (data.code == 200) {
      loadingAction(false);

      postListController[postListController
          .indexWhere((element) => element.slug == postSlug)] = data.data;
      snackBarMessage(
          title: 'Edit idea successful!', backGroundColor: successColor);
      Get.back();
      update();
    } else {
      loadingAction(false);
    }
  }

  deleteIdea(String threadSLug, String postSLug) async {
    try {
      loadingAction(true);
      final data = await PostData.deletePost(threadSLug, postSLug);
      if (data.code == 200) {
        postListController.removeWhere((element) => element.slug == postSLug);
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('delete idea error $e');
    } finally {
      loadingAction(false);
    }
  }

  bool checkDeadlinePost(int deadline) {
    return DateTime.now().toUtc().isAfter(
          DateTime.fromMillisecondsSinceEpoch(
            deadline,
            isUtc: false,
          ).toUtc(),
        );
  }

  var nameSlug = SharedPreferencesHelper.instance.getString(key: 'nameSlug');

  bool checkLiked(
    String postSlug,
  ) {
    var listVoteInIdea = postListController
        .firstWhere((element) => element.slug == postSlug)
        .upvotes;
    return listVoteInIdea.any((element) => element.slug == nameSlug);
  }

  bool checkDisLiked(
    String postSlug,
  ) {
    var listVoteInIdea = postListController
        .firstWhere((element) => element.slug == postSlug)
        .downvotes;
    return listVoteInIdea.any((element) => element.slug == nameSlug);
  }

  chooseLike(
    String title,
    bool checkClickAction, {
    String threadSlug,
    String postSlug,
  }) async {
    var listLike = postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .upvotes;
    var disListLike = postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
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
    postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .oneClickAction = false;
    postListController.refresh();

    final data = await PostData.likePost(threadSlug, postSlug);
    if (data.code != 200) {
      postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .oneClickAction = true;
      if (listLike.isNotEmpty) listLike.removeLast();
    } else {
      postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .oneClickAction = false;
    }
    print(listLike.length);
  }

  chooseDisLike(
    String title,
    bool checkClickAction, {
    String threadSlug,
    String postSlug,
  }) async {
    var disListLike = postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .downvotes;
    var listLike = postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
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
    postListController
        .firstWhere(
            (element) => element.title == title && element.slug == postSlug)
        .oneClickAction = false;
    postListController.refresh();
    final data = await PostData.disLikePost(threadSlug, postSlug);
    if (data.code != 200) {
      postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .oneClickAction = true;
      if (disListLike.isNotEmpty) disListLike.removeLast();
    } else {
      postListController
          .firstWhere(
              (element) => element.title == title && element.slug == postSlug)
          .oneClickAction = false;
    }
    print(disListLike.length);
  }

  deletePostofmanage(String postSlug) async {
    try {
      loadingAction(true);
      final data = await PostData.deletePostofManage(postSlug);
      if (data.code == 200) {
        if (postListManageController
            .any((element) => element.slug == postSlug)) {
          postListManageController
              .removeWhere((element) => element.slug == postSlug);
        }
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (r) {
      print('delete post error $r');
    } finally {
      loadingAction(false);
    }
  }
}
