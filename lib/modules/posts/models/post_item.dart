import 'package:comp1640_web/modules/posts/models/comment_item.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class PostItem {
  String thread;
  String title;
  String content;
  Author author;
  String slug;
  List<String> upvotes;
  List<String> downvotes;
  List<CommentItem> comments;
  String category;
  String createdAt;
  String updatedAt;
  bool oneClickAction;

  PostItem(
      {this.thread,
      this.title,
      this.content,
      this.author,
      this.upvotes,
      this.downvotes,
      this.comments,
      this.slug,
      this.category,
      this.createdAt,
      this.updatedAt,
      this.oneClickAction = true});

  PostItem.fromJson(Map<String, dynamic> json) {
    thread = json['thread'];
    title = json['title'];
    content = json['content'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
    if (json['comments'] != null) {
      comments = <CommentItem>[];
      json['comments'].forEach((v) {
        comments.add(CommentItem.fromJson(v));
      });
    }
    slug = json['slug'];
    category = json['category'];
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
    data['thread'] = thread;
    data['title'] = title;
    data['content'] = content;
    data['upvotes'] = upvotes;
    data['downvotes'] = downvotes;
    if (author != null) {
      data['author'] = author.toJson();
    }
    if (comments != null) {
      data['comments'] = author.toJson();
    }
    data['slug'] = slug;
    data['category'] = category;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Author {
  String sId;
  String email;
  String username;

  Author({this.sId, this.email, this.username});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}
