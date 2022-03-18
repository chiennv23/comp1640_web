import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/posts/DA/post_data.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  ThreadController threadController = Get.find();

  RxBool isLoading = true.obs;
  final postListController = <PostItem>[].obs;

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
        postListController.assignAll(data?.data);
      } else {
        snackBarMessageError(data.message);
      }
    } finally {
      isLoading(false);
    }
  }

  List<PostItem> get postList {
    return [...postListController];
  }

  createIdea(
      {String threadSlug, String title, String content, int deadline}) async {
    try {
      final data =
          await PostData.createPost(threadSlug, title, content, deadline);
      if (data.code == 200) {
        print(data.data);
        postListController.insert(0, data.data);
        snackBarMessage(
            title: 'Create idea successful!', backGroundColor: successColor);
        Get.back();
        update();
      } else {
        snackBarMessageError(data.message);
      }
    } catch (e) {
      print('create idea error $e');
    }
  }

  chooseLike(String title) {
    var listLike =
        postListController.firstWhere((element) => element.title == title).upvotes;
    listLike.add('like');
    print(listLike.length);
    update();
  }

  chooseDisLike(String title) {
    var disListLike =
        postListController.firstWhere((element) => element.title == title).downvotes;
    disListLike.add('dislike');
    print(disListLike.length);
    update();
  }

  chooseLikeCmt({String title, String content}) {
    var listLike = postListController
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .upvotes;
    listLike.add('like');
    print(listLike.length);
    update();
  }

  chooseDisLikeCmt({String title, String content}) {
    var disListLike = postListController
        .firstWhere((element) => element.title == title)
        .comments
        .firstWhere((e) => e.content == content)
        .downvotes;
    disListLike.add('dislike');
    print(disListLike.length);
    update();
  }
}
