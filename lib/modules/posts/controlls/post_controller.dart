import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:http/http.dart' as http;

class PostController {
  static String url = '$urlApi/threads';

  // static Future<BasicResponse<List<ThreadsItem>>> getAllPost() async {
  //   final response =
  //       await BaseDA.getList(url, (json) => ThreadsItem.fromJsonToList(json));
  //   return response;
  // }
}
