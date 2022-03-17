import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/posts/DA/post_data.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  ThreadController threadController = Get.find();

  RxBool isLoading = true.obs;
  final _postList = <PostItem>[].obs;

  @override
  void onInit() {
    callListIntoDA();
    super.onInit();
  }

  Future callListIntoDA() async {
    try {
      isLoading(true);
      var firstSlug =
          SharedPreferencesHelper.instance.getString(key: 'firstSlug');
      final data = await PostData.getAllPostByThread(
          threadController.slugSelected.value != ''
              ? threadController.slugSelected.value
              : firstSlug);
      if (data.code == 200) {
        _postList.assignAll(data?.data);
      } else {
        snackBarMessageError(data.message);
      }
    } finally {
      isLoading(false);
    }
  }

  List<PostItem> get postList {
    return [..._postList];
  }

  chooseLike(String title) {
    var listLike =
        _postList.firstWhere((element) => element.title == title).upvotes;
    listLike.add('like');
    print(listLike.length);
    update();
  }

  chooseDisLike(String title) {
    var disListLike =
        _postList.firstWhere((element) => element.title == title).downvotes;
    disListLike.add('dislike');
    print(disListLike.length);
    update();
  }

  chooseLikeCmt({String title, String content}) {
    var listLike = _postList
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .upvotes;
    listLike.add('like');
    print(listLike.length);
    update();
  }

  chooseDisLikeCmt({String title, String content}) {
    var disListLike = _postList
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .downvotes;
    disListLike.add('dislike');
    print(disListLike.length);
    update();
  }
}
