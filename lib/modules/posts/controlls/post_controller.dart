import 'package:comp1640_web/config/config_Api.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static String url = '$urlApi/threads';

  // static Future<BasicResponse<List<ThreadItem>>> getAllPost() async {
  //   final response =
  //       await BaseDA.getList(url, (json) => ThreadsItem.fromJsonToList(json));
  //   return response;
  // }
}
