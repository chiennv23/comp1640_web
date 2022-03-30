import 'package:comp1640_web/modules/posts/models/post_item.dart';

class ThreadItem {
  String sId;
  String topic;
  String description;
  Creator creator;
  String slug;
  List<Posts> posts;
  int createdAt;
  int updatedAt;
  int deadlineIdea;
  int deadlineComment;
  bool approved;

  ThreadItem(
      {this.sId,
      this.topic,
      this.description,
      this.creator,
      this.slug,
      this.posts,
      this.createdAt,
      this.updatedAt,
      this.deadlineIdea,
      this.deadlineComment,
      this.approved});

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
    approved = json['approved'] ?? false;
    deadlineIdea =
        json['postDeadline'] ?? DateTime.now().toUtc().millisecondsSinceEpoch;
    deadlineComment = json['commentDeadline'] ??
        DateTime.now().toUtc().millisecondsSinceEpoch;
  }

  static List<ThreadItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => ThreadItem.fromJson(c)).toList();
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
}

class Posts {
  String sId;
  String title;
  String content;
  Creator author;
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
    author = json['author'] != null ? Creator.fromJson(json['author']) : null;
    slug = json['slug'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
  }
}
