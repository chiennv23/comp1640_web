import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/comments/models/comment_item.dart';

class CommentData {
  static Future<BasicResponse<CommentItem>> createComment(
      {String threadSlug,
      String postSlug,
      String title,
      String content,
      bool anonymous = false}) async {
    final response = await BaseDA.post(
        urlPostNewComment(threadSlug: threadSlug, postSlug: postSlug),
        {"title": title, "content": content, "anonymous": anonymous},
        (json) => CommentItem.fromJson(json));
    if (response.code == 200) {
      print('Create comment done');
    }
    return response;
  }

  static Future<BasicResponse> likeComment(
      String threadSlug, String postSlug, String cmtSlug) async {
    var response = await BaseDA.post(
        urlLikeComment(threadSlug: threadSlug, postSlug: postSlug,cmtSlug:cmtSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('like cmt done.');
    }
    return response;
  }

  static Future<BasicResponse> disLikeComment(
      String threadSlug, String postSlug, String cmtSlug) async {
    var response = await BaseDA.post(
        urlDislikeComment(threadSlug: threadSlug, postSlug: postSlug,cmtSlug:cmtSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('dislike cmt done.');
    }
    return response;
  }
}
