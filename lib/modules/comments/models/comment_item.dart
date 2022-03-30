import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class CommentItem {
  String id;
  Creator author;
  String title;
  String content;
  String slug;
  List<String> upvotes;
  List<String> downvotes;
  int createdAt;
  int updatedAt;

  CommentItem(
      {this.author,
      this.id,
      this.title,
      this.content,
      this.slug,
      this.upvotes,
      this.downvotes,
      this.createdAt,
      this.updatedAt});

  CommentItem.fromJson(Map<String, dynamic> json) {
    author = json['author'] != null ? Creator.fromJson(json['author']) : null;
    title = json['title'];
    id = json['_id'];
    content = json['content'];
    slug = json['slug'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class Author {
  String email;
  String username;
  String role;
  String slug;

  Author({this.email, this.username, this.role, this.slug});

  Author.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    role = json['role'];
    slug = json['slug'];
  }
}
