import 'package:comp1640_web/modules/posts/models/post_item.dart';

class ThreadItem {
  String sId;
  String topic;
  String description;
  Creator creator;
  String slug;
  List<Posts> posts;
  String createdAt;
  String updatedAt;

  ThreadItem({
    this.sId,
    this.topic,
    this.description,
    this.creator,
    this.slug,
    this.posts,
    this.createdAt,
    this.updatedAt,
  });

  ThreadItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    description = json['description'];
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    slug = json['slug'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts.add(Posts.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  static List<ThreadItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => ThreadItem.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['topic'] = topic;
    data['description'] = description;
    if (creator != null) {
      data['creator'] = creator.toJson();
    }
    data['slug'] = slug;
    if (posts != null) {
      data['posts'] = posts.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Creator {
  String sId;
  String email;
  String username;
  String role;
  String slug;

  Creator({this.sId, this.email, this.username, this.role, this.slug});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    role = json['role'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['username'] = username;
    data['role'] = role;
    data['slug'] = slug;
    return data;
  }
}

class Posts {
  String sId;
  String title;
  String content;
  String author;
  String slug;
  List<String> upvotes;
  List<String> downvotes;

  Posts(
      {this.sId,
      this.title,
      this.content,
      this.author,
      this.slug,
      this.upvotes,
      this.downvotes});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    author = json['author'];
    slug = json['slug'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['author'] = this.author;
    data['slug'] = this.slug;
    data['upvotes'] = upvotes;
    data['downvotes'] = downvotes;
    return data;
  }
}
