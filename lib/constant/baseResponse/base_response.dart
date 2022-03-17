import 'dart:convert';
import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BaseDA {
  static Future<BasicResponse<T>> post<T>(
      String url, dynamic obj, T Function(Object json) fromJson,
      {String version, String token}) async {
    obj ??= {};
    try {
      var headers = <String, String>{};
      var token =
          SharedPreferencesHelper.instance.getString(key: 'accessToken');
      if (token != null) {
        headers = <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        };
      } else {
        headers = <String, String>{
          'Content-type': 'application/json',
        };
      }

      final jsonObj = obj == null ? null : json.encode(obj);
      print(jsonObj);
      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonObj);
      if (response.statusCode != 200) {
        print('fail!');
        print(response.statusCode.toString());
        if (response.statusCode == 401) {
          print('fail authen.');

          var rs = await postRefreshToken();
          if (rs.statusCode == 200) {
            token =
                SharedPreferencesHelper.instance.getString(key: 'accessToken');
            headers = <String, String>{
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            };
            final jsonObj = obj == null ? null : json.encode(obj);
            print(jsonObj);
            final response = await http.post(Uri.parse(url),
                headers: headers, body: jsonObj);
            if (response.statusCode == 200) {
              print(json.encode(jsonDecode(response.body)));
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
        if (response.statusCode == 403) {
          var responseFail = BasicResponse<T>();
          responseFail.code = response.statusCode;
          responseFail.message = response.body;
          snackBarMessageError(responseFail.message);
          return responseFail;
        }
        if (response.statusCode == 500) {
          snackBarMessageError401('Server error!');
        }
        var responseFail = BasicResponse<T>();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        return responseFail;
      } else {
        var b = BasicResponse<T>();
        b.data = fromJson(jsonDecode(response.body));
        b.code = 200;
        return b;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<BasicResponse<T>> delete<T>(
      String url, dynamic obj, T Function(Object json) fromJson,
      {String version, String token}) async {
    obj ??= {};
    try {
      var headers = <String, String>{};
      var token =
          SharedPreferencesHelper.instance.getString(key: 'accessToken');
      if (token != null) {
        headers = <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        };
      } else {
        headers = <String, String>{
          'Content-type': 'application/json',
        };
      }

      final jsonObj = obj == null ? null : json.encode(obj);
      print(jsonObj);
      final response =
          await http.delete(Uri.parse(url), headers: headers, body: jsonObj);
      if (response.statusCode != 200) {
        print('fail!');
        print(response.statusCode.toString());
        if (response.statusCode == 401) {
          print('fail authen.');
          var rs = await postRefreshToken();
          if (rs.statusCode == 200) {
            token =
                SharedPreferencesHelper.instance.getString(key: 'accessToken');
            headers = <String, String>{
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            };
            final jsonObj = obj == null ? null : json.encode(obj);
            print(jsonObj);
            final response = await http.delete(Uri.parse(url),
                headers: headers, body: jsonObj);
            if (response.statusCode == 200) {
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
        if (response.statusCode == 403) {
          snackBarMessageError401('You are not authorized.');
        }
        if (response.statusCode == 500) {
          snackBarMessageError401('Server error!');
        }
        var responseFail = BasicResponse<T>();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        return responseFail;
      } else {
        var b = BasicResponse<T>();
        b.data = fromJson(jsonDecode(response.body));
        b.code = 200;
        return b;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<BasicResponse<T>> put<T>(
      String url, dynamic obj, T Function(Object json) fromJson,
      {String version, String token}) async {
    obj ??= {};
    try {
      var headers = <String, String>{};
      var token =
          SharedPreferencesHelper.instance.getString(key: 'accessToken');
      if (token != null) {
        headers = <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        };
      } else {
        headers = <String, String>{
          'Content-type': 'application/json',
        };
      }

      final jsonObj = obj == null ? null : json.encode(obj);
      print(jsonObj);
      final response =
          await http.put(Uri.parse(url), headers: headers, body: jsonObj);
      if (response.statusCode != 200) {
        print('fail!');
        print(response.statusCode.toString());
        if (response.statusCode == 401) {
          print('fail authen.');
          var rs = await postRefreshToken();
          if (rs.statusCode == 200) {
            token =
                SharedPreferencesHelper.instance.getString(key: 'accessToken');
            headers = <String, String>{
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            };
            final jsonObj = obj == null ? null : json.encode(obj);
            print(jsonObj);
            final response =
                await http.put(Uri.parse(url), headers: headers, body: jsonObj);
            if (response.statusCode == 200) {
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
        if (response.statusCode == 403) {
          snackBarMessageError401('You are not authorized.');
        }
        if (response.statusCode == 500) {
          snackBarMessageError401('Server error!');
        }
        var responseFail = BasicResponse<T>();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        return responseFail;
      } else {
        var b = BasicResponse<T>();
        b.data = fromJson(jsonDecode(response.body));
        b.code = 200;
        return b;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<T> get<T extends BasicResponse>(
      String url, T Function(Object json) fromJson,
      {String version, String token}) async {
    try {
      var headers = <String, String>{};
      headers = <String, String>{
        'Content-type': 'application/json',
      };

      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        print('fail!');

        var responseFail = BasicResponse();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        return responseFail;
      } else {
        var b = fromJson(response.body);
        b.code = 200;
        return b;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<BasicResponse<T>> getList<T>(
      String url, T Function(Object json) fromJson,
      {String version, String token}) async {
    try {
      var headers = <String, String>{};
      headers = <String, String>{
        'Content-type': 'application/json',
      };
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        print('fail!');

        var responseFail = BasicResponse();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        return responseFail;
      } else {
        var b = BasicResponse<T>();
        b.data = fromJson(jsonDecode(response.body));
        b.code = 200;
        return b;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<http.BaseResponse> postRefreshToken() async {
  print('refreshToken doing...');
  var refreshToken =
      SharedPreferencesHelper.instance.getString(key: 'refreshToken');
  var response = await http
      .post(Uri.parse(urlRefreshToken), body: {"refreshToken": refreshToken});
  Map<String, dynamic> ms = json.decode(response.body);

  if (response.statusCode == 200) {
    SharedPreferencesHelper.instance
        .setString(key: 'accessToken', val: ms['accessToken']);
    print('accessToken ${ms['accessToken']}');
  } else if (response.statusCode == 401) {
    snackBarMessageError401('Session is over. Please login again!');
    SharedPreferencesHelper.instance.clearAllKeys();
    Get.offAllNamed(loginPageRoute);
  } else {
    snackBarMessageError(response.body);
  }
  return response;
}

class BasicResponse<T> {
  String message;
  int code;
  T data;
  List<T> datas;

  BasicResponse();

  BasicResponse.fromJson(Object json) {
    data = json;
    message = json.toString();
  }
}
