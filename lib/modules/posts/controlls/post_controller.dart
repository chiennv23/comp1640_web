import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:http/http.dart' as http;

class PostController {
  static String url = '$urlApi/posts';

  static Future<BasicResponse<List<PostsItem>>> getAllPost() async {
    final response =
        await BaseDA.getList(url, (json) => PostsItem.fromJsonToList(json));
    return response;
  }
}
