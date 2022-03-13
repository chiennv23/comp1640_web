import 'package:comp1640_web/modules/posts/models/comment_item.dart';
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
  String createdAt;
  String updatedAt;
  bool oneClickAction;

  PostItem(
      {this.sId,
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
      this.oneClickAction = true});

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
    oneClickAction = true;
  }

  static List<PostItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => PostItem.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (thread != null) {
      data['thread'] = thread.toJson();
    }
    data['title'] = title;
    data['content'] = content;
    data['slug'] = slug;
    data['upvotes'] = upvotes;
    data['downvotes'] = downvotes;
    if (author != null) {
      data['author'] = author.toJson();
    }
    if (comments != null) {
      data['comments'] = author.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Comment {
  String sId;
  String author;
  String content;
  List<String> upvotes;
  List<String> downvotes;
  String slug;

  Comment({this.sId, this.author, this.content, this.upvotes, this.downvotes,this.slug});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    content = json['content'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
    slug = json['slug'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['topic'] = topic;
    data['description'] = description;
    if (creator != null) {
      data['creator'] = creator.toJson();
    }
    data['slug'] = slug;
    return data;
  }
}
