import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseDA {
  static Future<T> post<T extends BasicResponse>(
      String url, dynamic obj, T Function(Object json) fromJson,
      {String version, String token}) async {
    obj ??= {};
    try {
      var headers = <String, String>{};
      headers = <String, String>{
        'Content-type': 'application/json',
      };
      final jsonObj = obj == null ? null : json.encode(obj);
      print(jsonObj);

      final response =
          await http.post(Uri.parse(url), headers: headers, body: jsonObj);
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
      // headers = <String, String>{
      //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      //   "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
      //   "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      //   "Access-Control-Allow-Methods": "POST, OPTIONS"
      // };
      print(url);
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

class BasicResponse<T> {
  String message;
  int code;
  T data;
  List<T> datas;

  BasicResponse();

  BasicResponse.fromJson(Object json) {
    message = json.toString();
  }
}
