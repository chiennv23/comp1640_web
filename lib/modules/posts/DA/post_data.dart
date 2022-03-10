import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';

class PostData {
  static Future<BasicResponse<List<PostItem>>> getAllPostByThread(
      String threadSlug) async {
    final response = await BaseDA.getList(
        urlGetAllPosts(threadSlug: threadSlug),
        (json) => PostItem.fromJsonToList(json));
    return response;
  }
}
