import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/modules/posts/DA/post_data.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  ThreadController threadController = Get.find();

  RxBool isLoading = true.obs;
  final _postList = [].obs;

  @override
  void onInit() {
    callListIntoDA();
    super.onInit();
  }

  Future callListIntoDA() async {
    try {
      isLoading(true);
      final data = await PostData.getAllPostByThread(
          threadController.ThreadList.first.slug);

      _postList.assignAll(data?.data);
    } finally {
      isLoading(false);
    }
  }

  List<PostItem> get postList {
    return [..._postList];
  }
}
