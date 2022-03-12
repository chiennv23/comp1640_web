import 'dart:math';

import 'package:collection/src/iterable_extensions.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/threads/DA/thread_data.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ThreadController extends GetxController {
  RxBool isLoading = true.obs;
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

  deleteThread(String threadSLug) {
    _threadList.removeWhere((element) => element.slug == threadSLug);
    print(_threadList.length);
  }
}
