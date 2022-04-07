import 'package:comp1640_web/modules/comments/models/comment_item.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';

class PostItem {
  int indexSTT;
  String sId;
  Thread thread;
  String title;
  String content;
  Creator author;
  String slug;
  List<Files> files;
  List<String> upvotes;
  List<String> downvotes;
  List<Comment> comments;
  int createdAt;
  int updatedAt;
  int mostPoint;
  bool anonymous;
  bool oneClickAction;
  bool checkComment;

  PostItem({
    this.indexSTT = 0,
    this.mostPoint = 0,
    this.sId,
    this.thread,
    this.title,
    this.content,
    this.author,
    this.slug,
    this.files,
    this.upvotes,
    this.downvotes,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.oneClickAction = true,
    this.checkComment = false,
  });

  var index = 0;

  PostItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    thread = json['thread'] != null ? Thread.fromJson(json['thread']) : null;
    title = json['title'];
    content = json['content'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files.add(Files.fromJson(v));
      });
    }
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
    mostPoint = upvotes.length - downvotes.length;
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

class Files {
  String assetId;
  String publicId;
  int version;
  String versionId;
  String signature;
  int width;
  int height;
  String format;
  String resourceType;
  String createdAt;
  int bytes;
  String type;
  String etag;
  bool placeholder;
  String url;
  String secureUrl;
  String originalFilename;
  String originalExtension;
  String apiKey;

  Files(
      {this.assetId,
      this.publicId,
      this.version,
      this.versionId,
      this.signature,
      this.width,
      this.height,
      this.format,
      this.resourceType,
      this.createdAt,
      this.bytes,
      this.type,
      this.etag,
      this.placeholder,
      this.url,
      this.secureUrl,
      this.originalFilename,
      this.originalExtension,
      this.apiKey});

  Files.fromJson(Map<String, dynamic> json) {
    assetId = json['asset_id'];
    publicId = json['public_id'];
    version = json['version'];
    versionId = json['version_id'];
    signature = json['signature'];
    width = json['width'];
    height = json['height'];
    format = json['format'];
    resourceType = json['resource_type'];
    createdAt = json['created_at'];
    bytes = json['bytes'];
    type = json['type'];
    etag = json['etag'];
    placeholder = json['placeholder'];
    url = json['url'];
    secureUrl = json['secure_url'];
    originalFilename = json['original_filename'];
    originalExtension = json['original_extension'];
    apiKey = json['api_key'];
  }
}
