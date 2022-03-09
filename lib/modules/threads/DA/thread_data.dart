import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class ThreadData {
  static Future<BasicResponse<List<ThreadItem>>> getAllThreads() async {
    final response = await BaseDA.getList(
        urlGetAllThread, (json) => ThreadItem.fromJsonToList(json));
    return response;
  }
}
