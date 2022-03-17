import 'package:comp1640_web/modules/comments/models/comment_item.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';

class user_items {
  UserItem user;
  String accessToken;
  String refreshToken;

  user_items({this.user});

  user_items.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserItem.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
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
  int createdAt;
  int updatedAt;

  UserItem({
    this.sId,
    this.email,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.role,
  });

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
  int createdAt;

  OtherList({this.sId, this.title, this.slug, this.createdAt});

  OtherList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    createdAt = json['createdAt'];
  }
}
