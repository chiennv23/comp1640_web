import 'dart:math';

import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/threads/DA/thread_data.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/modules/threads/view/create_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ThreadController extends GetxController {
  RxBool isLoadingFirst = true.obs;
  RxBool isLoadingAction = false.obs;
  final _threadList = <ThreadItem>[].obs;
  final _threadManageList = <ThreadItem>[].obs;
  var threadSelected = ''.obs;
  var slugSelected = ''.obs;

  var threadChartSelected = ''.obs;
  var slugChartSelected = ''.obs;
  var deadlineIdeaSelectedThread = 0.obs;
  var deadlineCommentSelectedThread = 0.obs;

  @override
  void onInit() {
    callListIntoDA();
    super.onInit();
  }

  Future callListIntoDA() async {
    try {
      isLoadingFirst(true);
      final data = await ThreadData.getAllThreads();
      if (data.code == 200) {
        _threadList.assignAll(data?.data);
        slugSelected.value = data?.data?.first?.slug;
        slugChartSelected.value = data?.data?.first?.slug;
        deadlineIdeaSelectedThread.value = data?.data?.first?.deadlineIdea;
        deadlineCommentSelectedThread.value =
            data?.data?.first?.deadlineComment;
        SharedPreferencesHelper.instance
            .setString(key: 'firstSlug', val: data?.data?.first?.slug);
        threadSelected.value = _threadList.first.topic;
        threadChartSelected.value = _threadList.first.topic;
      } else {
        _threadList;
      }
    } catch (e) {
      print('thread error $e');
    } finally {
      isLoadingFirst(false);
    }
  }

  Future callListManageThread() async {
    try {
      isLoadingFirst(true);
      final data = await ThreadData.getAllManageThreads();
      if (data.code == 200) {
        _threadManageList.assignAll(data?.data);
      } else {
        _threadManageList;
      }
    } catch (e) {
      print('manage thread error $e');
    } finally {
      isLoadingFirst(false);
    }
  }

  List<ThreadItem> get ThreadList {
    return [..._threadList];
  }

  List<ThreadItem> get myThreadList {
    var name = SharedPreferencesHelper.instance.getString(key: 'UserName');
    var email = SharedPreferencesHelper.instance.getString(key: 'Email');
    return [..._threadList]
        .where((element) =>
            element.creator.username == name && element.creator.email == email)
        .toList();
  }

  List<ThreadItem> get threadManageList {
    return [..._threadManageList];
  }

  bool get checkDeadlineCreateIdea {
    if (ThreadList.length == 1) {
      return DateTime.now().toUtc().isAfter(
            DateTime.fromMillisecondsSinceEpoch(
              ThreadList.first.deadlineIdea,
              isUtc: false,
            ).toUtc(),
          );
    }
    return DateTime.now().toUtc().isAfter(
          DateTime.fromMillisecondsSinceEpoch(
            deadlineIdeaSelectedThread.value,
            isUtc: false,
          ).toUtc(),
        );
  }

  bool get checkDeadlineComment {
    if (ThreadList.length == 1) {
      return DateTime.now().toUtc().isAfter(
            DateTime.fromMillisecondsSinceEpoch(
              ThreadList.first.deadlineComment,
              isUtc: false,
            ).toUtc(),
          );
    }
    return DateTime.now().toUtc().isAfter(
          DateTime.fromMillisecondsSinceEpoch(
            deadlineCommentSelectedThread.value,
            isUtc: false,
          ).toUtc(),
        );
  }

  loadingAction(bool checkLoading) => isLoadingAction.value = checkLoading;

  List<charts.Series<ThreadItem, String>> get threadAndPostChart {
    var list = [..._threadList]
      ..sort((b, a) => a.posts.length.compareTo(b.posts.length));
    return [
      charts.Series<ThreadItem, String>(
        id: 'Threads',
        colorFn: (ThreadItem thread, count) {
          var post = thread.posts.length;
          var postMax = _threadList.map((m) => m.posts.length).reduce(max);
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
        domainFn: (ThreadItem thread, _) => thread.topic,
        measureFn: (ThreadItem thread, _) => thread.posts.length,
        labelAccessorFn: (ThreadItem thread, _) =>
            '${thread.topic}: ${thread.posts.length.toString()} ideas',
        data: list,
      ),
    ];
  }

  int get AllPostInThread {
    var list = [..._threadList];
    int allPost = 0;
    var leg = 0;
    for (final item in list) {
      leg = item.posts.length;
      allPost += leg;
    }
    return allPost;
  }

  threadChangeChoose(
      {String thread = '',
      String slug,
      int deadlineIdea,
      int deadlineComment}) {
    threadSelected.value = thread;
    slugSelected.value = slug;
    deadlineIdeaSelectedThread.value = deadlineIdea;
    deadlineCommentSelectedThread.value = deadlineComment;
  }

  threadChartChoose({
    String thread = '',
    String slug,
  }) {
    threadChartSelected.value = thread;
    slugChartSelected.value = slug;
  }

  createThread(
      {String title,
      String content,
      int deadlineIdea,
      int deadlineComment,
      bool checkStaff = false}) async {
    try {
      loadingAction(true);
      final data = await ThreadData.createThread(
          title, content, deadlineIdea, deadlineComment);
      if (data.code == 200) {
        loadingAction(false);
        print(data.data);
        if (checkStaff) {
          // _threadList.insert(0, data.data);
          await Get.dialog(
            Center(
              child: SizedBox(
                width: 300,
                child: successDialog(),
              ),
            ),
          );
          snackBarMessage(
              title:
                  'Create successful! Waiting for Admin or Manager approved your thread',
              backGroundColor: successColor);
        } else {
          _threadManageList.insert(0, data.data);
          await Get.dialog(
            Center(
              child: SizedBox(
                width: 300,
                child: successDialog(
                  title: 'Successfully!',
                  subTitle: 'Create successful new thread',
                ),
              ),
            ),
          );
          snackBarMessage(
              title: 'Create successful!', backGroundColor: successColor);
        }
        update();
      }
    } catch (e) {
      print('create thread error $e');
    } finally {
      loadingAction(false);
    }
  }

  editThread(
      {String sid,
      String slug,
      String topic,
      String desc,
      int deadlineIdea,
      int deadlineComment}) async {
    try {
      loadingAction(true);
      final data = await ThreadData.editThread(
          threadSlug: slug,
          topic: topic,
          des: desc,
          deadlineIdea: deadlineIdea,
          deadlineComment: deadlineComment);
      if (data.code == 200) {
        _threadList[_threadList.indexWhere((element) => element.sId == sid)] =
            data.data;
        snackBarMessage(
            title: 'Edit successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('edit thread error $e');
    } finally {
      loadingAction(false);
    }
  }

  deleteThread(String threadSLug) async {
    try {
      loadingAction(true);
      final data = await ThreadData.deleteThread(threadSLug);
      if (data.code == 200) {
        _threadList.removeWhere((element) => element.slug == threadSLug);
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('delete thread error $e');
    } finally {
      loadingAction(false);
    }
  }

  editThreadManage(
      {String sid,
      String slug,
      int deadlineIdea,
      int deadlineComment,
      bool checkApprove}) async {
    try {
      loadingAction(true);
      final data = await ThreadData.editThreadManage(
        threadSlug: slug,
        deadlineIdea: deadlineIdea,
        deadlineComment: deadlineComment,
        checkApproveThread: checkApprove,
      );
      if (data.code == 200) {
        _threadManageList[
                _threadManageList.indexWhere((element) => element.sId == sid)]
            .approved = data.data.approved;
        _threadManageList[
                _threadManageList.indexWhere((element) => element.sId == sid)]
            .deadlineIdea = data.data.deadlineIdea;
        _threadManageList[
                _threadManageList.indexWhere((element) => element.sId == sid)]
            .deadlineComment = data.data.deadlineComment;
        _threadManageList.refresh();
        if (data.data.approved) {
          _threadList.insert(0, data.data);
        }
        snackBarMessage(
            title: 'Edit successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('edit thread manage error $e');
    } finally {
      loadingAction(false);
    }
  }

  deleteThreadManage(String threadSLug) async {
    try {
      loadingAction(true);
      final data = await ThreadData.deleteThreadManage(threadSLug);
      if (data.code == 200) {
        _threadManageList.removeWhere((element) => element.slug == threadSLug);
        _threadManageList.refresh();
        if (_threadList.any((element) => element.slug == threadSLug)) {
          _threadList.removeWhere((element) => element.slug == threadSLug);
        }
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (r) {
      print('delete thread error $r');
    } finally {
      loadingAction(false);
    }
  }
}
