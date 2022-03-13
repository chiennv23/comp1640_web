import 'dart:convert';
import 'dart:math';

import 'package:collection/src/iterable_extensions.dart';
import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/threads/DA/thread_data.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ThreadController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingAction = false.obs;
  final _threadList = <ThreadItem>[].obs;
  var threadSelected = ''.obs;
  var slugSelected = ''.obs;

  @override
  void onInit() {
    callListIntoDA();
    super.onInit();
  }

  Future callListIntoDA() async {
    try {
      isLoading(true);
      final data = await ThreadData.getAllThreads();
      if (data.code == 200) {
        _threadList.assignAll(data?.data);
        slugSelected.value = _threadList.first.slug;
      } else {
        _threadList;
      }
    } catch (e) {
      print('thread error $e');
    } finally {
      isLoading(false);
    }
  }

  List<ThreadItem> get ThreadList {
    return [..._threadList];
  }

  loadingAction(bool checkLoading) => isLoadingAction.value = checkLoading;

  List<charts.Series<ThreadItem, String>> get ThreadChart {
    return [
      charts.Series<ThreadItem, String>(
        id: 'Threads',
        colorFn: (ThreadItem thread, count) {
          var post = thread.posts.length;
          var postMax = _threadList
              .map((m) => m.posts.length)
              .reduce((current, next) => current > next ? current : next);
          if (post == postMax) {
            return charts.ColorUtil.fromDartColor(primaryColor2);
          } else if (post < postMax && post >= postMax / 2) {
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
            '${thread.topic}: ${thread.posts.length.toString()} posts',
        data: [..._threadList],
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

  threadChangeChoose({String thread = '', String slug}) {
    threadSelected.value = thread;
    slugSelected.value = slug;
  }

  createThread({String title, String content}) async {
    try {
      final data = await ThreadData.createThread(title, content);
      if (data.code == 200) {
        print(data.data);
        _threadList.add(data.data);
        snackBarMessage(
            title: 'Create successful!', backGroundColor: successColor);
        Get.back();
        update();
      } else {
        snackBarMessageError('');
      }
    } catch (e) {
      print('create thread error $e');
    }
  }

  editThread({String sid, String slug, String topic, String desc}) async {
    try {
      final data = await ThreadData.editThread(
          threadSlug: slug, topic: topic, des: desc);
      if (data.code == 200) {
        _threadList[_threadList.indexWhere((element) => element.sId == sid)] =
            data.data;
        snackBarMessage(
            title: 'Edit successful!', backGroundColor: successColor);
        Get.back();
        update();
      } else {
        snackBarMessageError('');
      }
    } catch (e) {
      print('edit thread error $e');
    }
  }

  deleteThread(String threadSLug) async {
    try {
      loadingAction(true);
      final data = await ThreadData.deleteThread(threadSLug);
      if (data.code == 200) {
        print(_threadList.length);
        _threadList.removeWhere((element) => element.slug == threadSLug);
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        print(_threadList.length);
        Get.back();
        update();
        loadingAction(false);
      } else {
        snackBarMessageError('');
      }
    } catch (e) {
      print('delete thread error $e');
    }
    print(_threadList.length);
  }
}
