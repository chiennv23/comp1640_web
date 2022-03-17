import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/comments/models/comment_item.dart';

class CommentData {
  static Future<BasicResponse> createComment(
      {String threadSlug,
      String postSlug,
      String title,
      String content}) async {
    final response = await BaseDA.post(
        urlPostNewComment(threadSlug: threadSlug, postSlug: postSlug),
        {"title": title, "content": content},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('Create comment done');
    } else {
      snackBarMessageError(response.message);
    }
    return response;
  }
}