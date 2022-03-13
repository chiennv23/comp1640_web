import 'package:comp1640_web/modules/posts/models/comment_item.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';

class user_items {
  UserItem user;

  user_items({this.user});

  user_items.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserItem.fromJson(json['user']) : null;
  }
}

class UserItem {
  String sId;
  String email;
  String username;
  String role;
  String slug;
  List<OtherList> posts;
  List<OtherList> comments;
  List<OtherList> threads;
  String createdAt;
  String updatedAt;
  String accessToken;
  String refreshToken;

  UserItem(
      {this.sId,
      this.email,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.username,
      this.role,
      this.accessToken,
      this.refreshToken});

  UserItem.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    role = json['role'];
    slug = json['slug'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts.add(OtherList.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(OtherList.fromJson(v));
      });
    }
    if (json['threads'] != null) {
      threads = [];
      json['threads'].forEach((v) {
        threads.add(OtherList.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['role'] = role;
    return data;
  }
}

class OtherList {
  String sId;
  String title;
  String slug;
  String createdAt;

  OtherList({this.sId, this.title, this.slug, this.createdAt});

  OtherList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    createdAt = json['createdAt'];
  }
}
