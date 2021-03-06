import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class ThreadData {
  static Future<BasicResponse<List<ThreadItem>>> getAllThreads() async {
    final response = await BaseDA.getList(
        urlGetAllThread, (json) => ThreadItem.fromJsonToList(json));
    if (response.code == 200) {
      print('List Threads done...${response.data.length}');
    }
    return response;
  }

  static Future<BasicResponse<List<ThreadItem>>> getAllManageThreads() async {
    final response = await BaseDA.getList(
        urlGetAllManageThread, (json) => ThreadItem.fromJsonToList(json));
    if (response.code == 200) {
      print('List Threads manage done...${response.data.length}');
    }
    return response;
  }

  static Future<BasicResponse<ThreadItem>> createThread(
      String topic, String des, int deadlineIdea, int deadlineComment) async {
    final response = await BaseDA.post(
        urlCreateThread,
        {
          "topic": topic,
          "description": des,
          "postDeadline": deadlineIdea,
          "commentDeadline": deadlineComment
        },
        (json) => ThreadItem.fromJson(json));
    if (response.code == 200) {
      print('Create thread done');
    }
    return response;
  }

  static Future<BasicResponse> deleteThread(String threadSlug) async {
    final response = await BaseDA.delete(
        urlDeleteThread(threadSlug: threadSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('Thread deleted.');
    }
    return response;
  }

  static Future<BasicResponse> deleteThreadManage(String threadSlug) async {
    final response = await BaseDA.delete(
        urlDeleteThreadofmanage(threadSlug: threadSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('Thread deleted.');
    }
    return response;
  }

  static Future<BasicResponse> editThread(
      {String threadSlug,
      String topic,
      String des,
      int deadlineIdea,
      int deadlineComment}) async {
    final response = await BaseDA.put(
        urlUpdateThread(threadSlug: threadSlug),
        {
          "topic": topic,
          "description": des,
          "postDeadline": deadlineIdea,
          "commentDeadline": deadlineComment
        },
        (json) => ThreadItem.fromJson(json));
    if (response.code == 200) {
      print('Thread edited.');
    }
    return response;
  }

  static Future<BasicResponse<ThreadItem>> editThreadManage({
    String threadSlug,
    int deadlineIdea,
    int deadlineComment,
    bool checkApproveThread,
  }) async {
    final response = await BaseDA.put(
        urlUpdateThreadofmanage(threadSlug: threadSlug),
        {
          "postDeadline": deadlineIdea,
          "commentDeadline": deadlineComment,
          "approved": checkApproveThread
        },
        (json) => ThreadItem.fromJson(json));
    if (response.code == 200) {
      print('Thread manage edited.');
    }
    return response;
  }
}
