class PostsItem {
  String sId;
  String title;
  String content;
  String updatedAt;
  AuthorItem author;

  // List<Null> upvotes;
  // List<Null> downvotes;
  List<CommentsItem> comments;

  PostsItem({
    this.sId,
    this.title,
    this.content,
    this.author,
    this.updatedAt,
    // this.upvotes,
    // this.downvotes,
    this.comments,
  });

  PostsItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] ?? 'This is title';
    content = json['content'] ?? 'This is content';
    updatedAt = json['updatedAt'] ?? '';
    author =
        json['author'] != null ? AuthorItem.fromJson(json['author']) : null;
    // if (json['upvotes'] != null) {
    //   upvotes = <Null>[];
    //   json['upvotes'].forEach((v) {
    //     upvotes.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['downvotes'] != null) {
    //   downvotes = <Null>[];
    //   json['downvotes'].forEach((v) {
    //     downvotes!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(CommentsItem.fromJson(v));
      });
    }
  }

  static List<PostsItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => PostsItem.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['content'] = content;
    data['updatedAt'] = updatedAt;
    if (author != null) {
      data['author'] = author.toJson();
    }
    // if (upvotes != null) {
    //   data['upvotes'] = upvotes.map((v) => v.toJson()).toList();
    // }
    // if (downvotes != null) {
    //   data['downvotes'] = downvotes.map((v) => v.toJson()).toList();
    // }
    if (comments != null) {
      data['comments'] = comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuthorItem {
  String sId;
  String email;
  String username;

  AuthorItem({this.sId, this.email, this.username});

  AuthorItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}

class CommentsItem {
  String sId;
  String content;
  AuthorItem author;
  List<String> upvotes;
  List<String> downvotes;

  CommentsItem(
      {this.sId, this.content, this.author, this.downvotes, this.upvotes});

  CommentsItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    author =
        json['author'] != null ? AuthorItem.fromJson(json['author']) : null;
    // if (json['upvotes'] != null) {
    //   upvotes = <Null>[];
    //   json['upvotes'].forEach((v) {
    //     upvotes.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['downvotes'] != null) {
    //   downvotes = <Null>[];
    //   json['downvotes'].forEach((v) {
    //     downvotes!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    if (author != null) {
      data['author'] = author.toJson();
    }
    // if (upvotes != null) {
    //   data['upvotes'] = upvotes.map((v) => v.toJson()).toList();
    // }
    // if (downvotes != null) {
    //   data['downvotes'] = downvotes.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
