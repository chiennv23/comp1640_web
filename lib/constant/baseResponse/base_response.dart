import 'dart:convert';
import 'dart:typed_data';
import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/config/config_Api.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
      // print(jsonObj);
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
        var responseFail = BasicResponse<T>();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        snackBarMessageError(responseFail.message);
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
      // print(jsonObj);
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
              print(json.encode(jsonDecode(response.body)));
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
        var responseFail = BasicResponse<T>();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        snackBarMessageError(responseFail.message);
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
      // print(jsonObj);
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
              print(json.encode(jsonDecode(response.body)));
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
        var responseFail = BasicResponse<T>();
        responseFail.code = response.statusCode;
        responseFail.message = response.body;
        snackBarMessageError(responseFail.message);
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

  static Future<BasicResponse<T>> postFormData<T>({
    String url,
    Uint8List bytes,
    String fileName,
    String mimeType,
    Map<String, String> obj,
    T Function(Object json) fromJson,
  }) async {
    // try {
    var token = SharedPreferencesHelper.instance.getString(key: 'accessToken');
    var headers = <String, String>{
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields.addAll(obj);
    if (bytes != null && fileName != '' && mimeType != '') {
      print(fileName);
      String mim1 = mimeType.split('/')[0];
      String mim2 = mimeType.split('/')[1];
      print(mim2);
      List<int> list = bytes.cast();
      request.files.add(http.MultipartFile.fromBytes('files', list,
          filename: fileName, contentType: MediaType(mim1, mim2)));
    }

    var response = await request.send();
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
            'Content-type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          };
          var request = http.MultipartRequest('POST', Uri.parse(url));
          request.headers.addAll(headers);
          request.fields.addAll(obj);
          if (bytes != null && fileName != '' && mimeType != '') {
            print(fileName);
            String mim1 = mimeType.split('/')[0];
            String mim2 = mimeType.split('/')[1];
            print(mim2);
            List<int> list = bytes.cast();
            request.files.add(http.MultipartFile.fromBytes('files', list,
                filename: fileName, contentType: MediaType(mim1, mim2)));
          }

          var response = await request.send();
          if (response.statusCode == 200) {
            var b = BasicResponse<T>();
            final res = await http.Response.fromStream(response);
            b.data = fromJson(jsonDecode(res.body));
            b.code = 200;
            return b;
          }
        }
      }
      // final res = await http.Response.fromStream(response);
      var responseFail = BasicResponse<T>();
      responseFail.code = response.statusCode;
      // responseFail.message = res.body;
      // snackBarMessageError(responseFail.message);
      return responseFail;
    } else {
      var b = BasicResponse<T>();
      final res = await http.Response.fromStream(response);
      b.data = fromJson(jsonDecode(res.body));
      b.code = 200;
      return b;
    }
    // } catch (e) {
    //   print(e);
    // }
  }static Future<BasicResponse<T>> putFormData<T>({
    String url,
    Uint8List bytes,
    String fileName,
    String mimeType,
    Map<String, String> obj,
    T Function(Object json) fromJson,
  }) async {
    // try {
    var token = SharedPreferencesHelper.instance.getString(key: 'accessToken');
    var headers = <String, String>{
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields.addAll(obj);
    if (bytes != null && fileName != '' && mimeType != '') {
      print(fileName);
      String mim1 = mimeType.split('/')[0];
      String mim2 = mimeType.split('/')[1];
      print(mim2);
      List<int> list = bytes.cast();
      request.files.add(http.MultipartFile.fromBytes('files', list,
          filename: fileName, contentType: MediaType(mim1, mim2)));
    }

    var response = await request.send();
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
            'Content-type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          };
          var request = http.MultipartRequest('PUT', Uri.parse(url));
          request.headers.addAll(headers);
          request.fields.addAll(obj);
          if (bytes != null && fileName != '' && mimeType != '') {
            print(fileName);
            String mim1 = mimeType.split('/')[0];
            String mim2 = mimeType.split('/')[1];
            print(mim2);
            List<int> list = bytes.cast();
            request.files.add(http.MultipartFile.fromBytes('files', list,
                filename: fileName, contentType: MediaType(mim1, mim2)));
          }

          var response = await request.send();
          if (response.statusCode == 200) {
            var b = BasicResponse<T>();
            final res = await http.Response.fromStream(response);
            b.data = fromJson(jsonDecode(res.body));
            b.code = 200;
            return b;
          }
        }
      }
      // final res = await http.Response.fromStream(response);
      var responseFail = BasicResponse<T>();
      responseFail.code = response.statusCode;
      // responseFail.message = res.body;
      // snackBarMessageError(responseFail.message);
      return responseFail;
    } else {
      var b = BasicResponse<T>();
      final res = await http.Response.fromStream(response);
      b.data = fromJson(jsonDecode(res.body));
      b.code = 200;
      return b;
    }
    // } catch (e) {
    //   print(e);
    // }
  }

  static Future<BasicResponse<T>> get<T>(
      String url, T Function(Object json) fromJson,
      {String version, String token}) async {
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

      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        print('fail!');
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
            final response = await http.get(
              Uri.parse(url),
              headers: headers,
            );
            if (response.statusCode == 200) {
              print(json.encode(jsonDecode(response.body)));
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
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
      print(e);
    }
  }

  static Future<BasicResponse<T>> getList<T>(
      String url, T Function(Object json) fromJson,
      {String version, String token}) async {
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
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        print('fail!');
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
            final response = await http.get(
              Uri.parse(url),
              headers: headers,
            );
            if (response.statusCode == 200) {
              print(json.encode(jsonDecode(response.body)));
              var b = BasicResponse<T>();
              b.data = fromJson(jsonDecode(response.body));
              b.code = 200;
              return b;
            }
          }
        }
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
    print('${ms['accessToken']}');
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
