import 'package:comp1640_web/modules/comments/models/comment_item.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class PostItem {
  String sId;
  Thread thread;
  String title;
  String content;
  Creator author;
  String slug;
  List<String> upvotes;
  List<String> downvotes;
  List<Comment> comments;
  int createdAt;
  int updatedAt;
  bool anonymous;
  bool oneClickAction;
  bool checkComment;

  PostItem({
    this.sId,
    this.thread,
    this.title,
    this.content,
    this.author,
    this.slug,
    this.upvotes,
    this.downvotes,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.oneClickAction = true,
    this.checkComment = false,
  });

  PostItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    thread = json['thread'] != null ? Thread.fromJson(json['thread']) : null;
    title = json['title'];
    content = json['content'];
    author = json['author'] != null ? Creator.fromJson(json['author']) : null;
    slug = json['slug'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(Comment.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    anonymous = json['anonymous'];
    oneClickAction = true;
    checkComment = false;
  }

  static List<PostItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => PostItem.fromJson(c)).toList();
  }
}

class Comment {
  String sId;
  Creator author;
  String content;
  List<String> upvotes;
  List<String> downvotes;
  String slug;
  bool oneClickActionCmt;
  bool anonymous;

  Comment(
      {this.sId,
      this.author,
      this.content,
      this.upvotes,
      this.downvotes,
      this.slug,
      this.oneClickActionCmt,
      this.anonymous});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'] != null ? Creator.fromJson(json['author']) : null;
    content = json['content'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
    slug = json['slug'];
    anonymous = json['anonymous'] ?? false;
    oneClickActionCmt = true;
  }
}

class Thread {
  String sId;
  String topic;
  String description;
  Creator creator;
  String slug;

  Thread({this.sId, this.topic, this.description, this.creator, this.slug});

  Thread.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    description = json['description'];
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    slug = json['slug'];
  }
}
