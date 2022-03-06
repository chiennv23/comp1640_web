import 'package:comp1640_web/modules/login/models/user_items.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';

class CommentItem {
  PostItem post;
  UserItem author;
  String title;
  String content;
  String slug;
  List<String> upvotes;
  List<String> downvotes;
  String createdAt;
  String updatedAt;

  CommentItem({this.post, this.author, this.title, this.content, this.slug, this.upvotes, this.downvotes, this.createdAt, this.updatedAt});

  CommentItem.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ?  PostItem.fromJson(json['post']) : null;
    author = json['author'] != null ?  UserItem.fromJson(json['author']) : null;
    title = json['title'];
    content = json['content'];
    slug = json['slug'];
    upvotes = json['upvotes'].cast<String>();
    downvotes = json['downvotes'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (post != null) {
      data['post'] = post.toJson();
    }
    if (author != null) {
      data['author'] = author.toJson();
    }
    data['title'] = title;
    data['content'] = content;
    data['slug'] = slug;
    data['upvotes'] = upvotes;
    data['downvotes'] = downvotes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
