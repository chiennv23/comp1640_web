import 'package:comp1640_web/modules/threads/DA/thread_data.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:get/get.dart';

class ThreadController extends GetxController {
  RxBool isLoading = true.obs;
  final _threadList = [].obs;

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
}
