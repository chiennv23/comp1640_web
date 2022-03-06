import 'package:comp1640_web/modules/posts/models/comment_item.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';

class UserItem {
  String email;
  String username;
  String password;
  String dob;
  String role;
  String slug;
  List<PostItem> posts;
  List<CommentItem> comments;
  List<PostItem> upvotedPosts;
  List<PostItem> downvotedPosts;
  List<CommentItem> upvotedComments;
  List<CommentItem> downvotedComments;
  String createdAt;
  String updatedAt;

  UserItem({this.email, this.username, this.password, this.dob, this.role, this.slug, this.posts, this.comments, this.upvotedPosts, this.downvotedPosts, this.upvotedComments, this.downvotedComments, this.createdAt, this.updatedAt});

  UserItem.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
    dob = json['dob'];
    role = json['role'];
    slug = json['slug'];
    if (json['posts'] != null) {
      posts = <PostItem>[];
      json['posts'].forEach((v) { posts.add( PostItem.fromJson(v)); });
    }
    if (json['comments'] != null) {
      comments = <CommentItem>[];
      json['comments'].forEach((v) { comments.add( CommentItem.fromJson(v)); });
    }
    if (json['upvotedPosts'] != null) {
      upvotedPosts = <PostItem>[];
      json['upvotedPosts'].forEach((v) { upvotedPosts.add( PostItem.fromJson(v)); });
    }
    if (json['downvotedPosts'] != null) {
      downvotedPosts = <PostItem>[];
      json['downvotedPosts'].forEach((v) { downvotedPosts.add( PostItem.fromJson(v)); });
    }
    if (json['upvotedComments'] != null) {
      upvotedComments = <CommentItem>[];
      json['upvotedComments'].forEach((v) { upvotedComments.add( CommentItem.fromJson(v)); });
    }
    if (json['downvotedComments'] != null) {
      downvotedComments = <CommentItem>[];
      json['downvotedComments'].forEach((v) { downvotedComments.add( CommentItem.fromJson(v)); });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    data['dob'] = dob;
    data['role'] = role;
    data['slug'] = slug;
    if (posts != null) {
      data['posts'] = posts.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments.map((v) => v.toJson()).toList();
    }
    if (upvotedPosts != null) {
      data['upvotedPosts'] = upvotedPosts.map((v) => v.toJson()).toList();
    }
    if (downvotedPosts != null) {
      data['downvotedPosts'] = downvotedPosts.map((v) => v.toJson()).toList();
    }
    if (upvotedComments != null) {
      data['upvotedComments'] = upvotedComments.map((v) => v.toJson()).toList();
    }
    if (downvotedComments != null) {
      data['downvotedComments'] = downvotedComments.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
