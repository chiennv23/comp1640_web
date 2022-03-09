
class ThreadItem {
  String topic;
  String description;
  String creator;
  String slug;
  List<String> posts;
  String createdAt;
  String updatedAt;

  ThreadItem(
      {this.topic,
        this.description,
        this.creator,
        this.slug,
        this.posts,
        this.createdAt,
        this.updatedAt});

  ThreadItem.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    description = json['description'];
    creator = json['creator'];
    slug = json['slug'];
    posts = json['posts'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  static List<ThreadItem> fromJsonToList(Object json) {
    var list = json as List;

    return list.map((c) => ThreadItem.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['topic'] = topic;
    data['description'] = description;
    data['creator'] = creator;
    data['slug'] = slug;
    data['posts'] = posts;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
