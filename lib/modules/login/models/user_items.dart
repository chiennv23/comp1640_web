import 'package:comp1640_web/modules/posts/models/comment_item.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';

class UserItem {
  String email;
  String username;
  String dob;
  String role;
  String accessToken;
  String refreshToken;

  UserItem(
      {this.email,
      this.username,
      this.dob,
      this.role,
      this.accessToken,
      this.refreshToken});

  UserItem.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    dob = json['dob'];
    role = json['role'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['dob'] = dob;
    data['role'] = role;
    return data;
  }
}
