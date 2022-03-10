import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class PostItem {
  String thread;
  String title;
  String content;
  Author author;
  String slug;
  String category;
  String createdAt;
  String updatedAt;

  PostItem(
      {this.thread,
      this.title,
      this.content,
      this.author,
      this.slug,
      this.category,
      this.createdAt,
      this.updatedAt});

  PostItem.fromJson(Map<String, dynamic> json) {
    thread = json['thread'];
    title = json['title'];
    content = json['content'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    slug = json['slug'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  static List<PostItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => PostItem.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thread'] = thread;
    data['title'] = title;
    data['content'] = content;
    if (author != null) {
      data['author'] = author.toJson();
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
