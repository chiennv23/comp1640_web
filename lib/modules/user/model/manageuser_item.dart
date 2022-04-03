import 'package:comp1640_web/modules/posts/models/post_item.dart';

class manageuser_item {
  String sId;
  String email;
  String username;
  String role;
  String slug;
  List<Threads> threads;
  List<Posts> posts;
  List<Posts> comments;
  List<Posts> upvotedPosts;
  List<Posts> downvotedPosts;
  List<Posts> upvotedComments;
  List<Posts> downvotedComments;
  int createdAt;
  int updatedAt;
  int iV;

  manageuser_item(
      {this.sId,
      this.email,
      this.username,
      this.role,
      this.slug,
      this.threads,
      this.posts,
      this.comments,
      this.upvotedPosts,
      this.downvotedPosts,
      this.upvotedComments,
      this.downvotedComments,
      this.createdAt,
      this.updatedAt,
      this.iV});

  manageuser_item.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    role = json['role'];
    slug = json['slug'];

    if (json['threads'] != null) {
      threads = <Threads>[];
      json['threads'].forEach((v) {
        threads.add(Threads.fromJson(v));
      });
    }

    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts.add(Posts.fromJson(v));
      });
    }
    if (json['upvotedPosts'] != null) {
      upvotedPosts = <Posts>[];
      json['upvotedPosts'].forEach((v) {
        upvotedPosts.add(Posts.fromJson(v));
      });
    }
    if (json['downvotedPosts'] != null) {
      downvotedPosts = <Posts>[];
      json['downvotedPosts'].forEach((v) {
        downvotedPosts.add(Posts.fromJson(v));
      });
    }
    if (json['upvotedComments'] != null) {
      upvotedComments = <Posts>[];
      json['upvotedComments'].forEach((v) {
        upvotedComments.add(Posts.fromJson(v));
      });
    }
    if (json['downvotedComments'] != null) {
      downvotedComments = <Posts>[];
      json['downvotedComments'].forEach((v) {
        downvotedComments.add(Posts.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(Posts.fromJson(v));
      });
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  static List<manageuser_item> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => manageuser_item.fromJson(c)).toList();
  }
}

class Threads {
  String sId;
  String topic;
  String description;
  String slug;
  int postDeadline;
  int commentDeadline;
  bool approved;

  Threads(
      {this.sId,
      this.topic,
      this.description,
      this.slug,
      this.postDeadline,
      this.commentDeadline,
      this.approved});

  Threads.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    description = json['description'];
    slug = json['slug'];
    postDeadline = json['postDeadline'];
    commentDeadline = json['commentDeadline'];
    approved = json['approved'];
  }
}

class Posts {
  String sId;
  String title;
  String content;
  String slug;
  bool anonymous;

  Posts({this.sId, this.title, this.content, this.slug, this.anonymous});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    slug = json['slug'];
    anonymous = json['anonymous'];
  }
}
