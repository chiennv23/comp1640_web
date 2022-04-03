import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/baseResponse/base_response.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/modules/user/model/manageuser_item.dart';


class UserData {
  static Future<BasicResponse<List<manageuser_item>>> getAllUsers() async {
    final response = await BaseDA.getList(
        urlGetallUser, (json) => manageuser_item.fromJsonToList(json));
    if (response.code == 200) {
      print('List Users done...${response.data.length}');
    }
    return response;
  }




  static Future<BasicResponse> deleteUser(String userSlug) async {
    final response = await BaseDA.delete(
        urlDeleteUsers(userSLug: userSlug),
        {},
        (json) => BasicResponse.fromJson(json));
    if (response.code == 200) {
      print('User deleted.');
    }
    return response;
  }

    static Future<BasicResponse<manageuser_item>> editUserManage({
    String userSlug,
    String role,
  }) async {
    final response = await BaseDA.put(
        urlUpdateUser (userSlug: userSlug),
        {
          "role": role
        },
        (json) => manageuser_item.fromJson(json));
    if (response.code == 200) {
      print('user manage edited.');
    }
    return response;
  }
}
