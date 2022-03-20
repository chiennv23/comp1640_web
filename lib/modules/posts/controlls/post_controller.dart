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

  RxBool isLoadingFirst = false.obs;
  RxBool isLoadingAction = false.obs;
  final postListController = <PostItem>[].obs;

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

  List<PostItem> get postList {
    return [...postListController];
  }

  bool loadingAction(bool loading) => isLoadingAction.value = loading;

  createIdea(
      {String threadSlug, String title, String content, int deadline}) async {
    try {
      loadingAction(true);
      final data =
          await PostData.createPost(threadSlug, title, content, deadline);
      if (data.code == 200) {
        postListController.insert(0, data.data);
        snackBarMessage(
            title: 'Create idea successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('create idea error $e');
    } finally {
      loadingAction(false);
    }
  }

  editIdea(
      {String threadSlug,
      String postSlug,
      String title,
      String content,
      int deadline}) async {
    try {
      loadingAction(true);
      final data = await PostData.editPost(
          threadSlug, postSlug, title, content, deadline);
      if (data.code == 200) {
        postListController[postListController
            .indexWhere((element) => element.slug == postSlug)] = data.data;
        snackBarMessage(
            title: 'Edit idea successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('Edit idea error $e');
    } finally {
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

  chooseLike(
    String title,
    bool checkClickAction, {
    String threadSlug,
    String postSlug,
  }) async {
    var listLike = postListController
        .firstWhere((element) => element.title == title)
        .upvotes;
    listLike.add('like');
    postListController
        .firstWhere((element) => element.title == title)
        .oneClickAction = false;
    postListController.refresh();

    final data = await PostData.likePost(threadSlug, postSlug);
    if (data.code != 200) {
      postListController
          .firstWhere((element) => element.title == title)
          .oneClickAction = true;
      if (listLike.isNotEmpty) listLike.removeLast();
    } else {
      postListController
          .firstWhere((element) => element.title == title)
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
        .firstWhere((element) => element.title == title)
        .downvotes;
    disListLike.add('dislike');
    postListController
        .firstWhere((element) => element.title == title)
        .oneClickAction = false;
    postListController.refresh();
    final data = await PostData.disLikePost(threadSlug, postSlug);
    if (data.code != 200) {
      postListController
          .firstWhere((element) => element.title == title)
          .oneClickAction = true;
      if (disListLike.isNotEmpty) disListLike.removeLast();
    } else {
      postListController
          .firstWhere((element) => element.title == title)
          .oneClickAction = false;
    }
    print(disListLike.length);
  }
}
