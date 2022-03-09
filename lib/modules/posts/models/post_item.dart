import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class PostItem {
  ThreadItem thread;
  String title;
  String content;
  String author;
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
    thread =
    json['thread'] != null ?  ThreadItem.fromJson(json['thread']) : null;
    title = json['title'];
    content = json['content'];
    author = json['author'];
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
    if (thread != null) {
      data['thread'] = thread.toJson();
    }
    data['title'] = title;
    data['content'] = content;
    data['author'] = author;
    data['slug'] = slug;
    data['category'] = category;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

