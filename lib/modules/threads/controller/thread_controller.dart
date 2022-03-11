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
      _threadList.assignAll(data?.data);
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
        colorFn: (_, count) {
          if (count < 3) {
            return charts.ColorUtil.fromDartColor(redColor);
          }
          return charts.ColorUtil.fromDartColor(primaryColor2);
        },
        domainFn: (ThreadItem thread, _) => thread.topic,
        measureFn: (ThreadItem thread, _) => thread.posts.length,
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
}
