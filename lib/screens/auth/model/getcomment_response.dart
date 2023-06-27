// To parse this JSON data, do
//
//     final GetCommentResponse = GetCommentResponseFromJson(jsonString);

import 'dart:convert';

List<GetCommentResponse> GetCommentResponseFromJson(String str) => List<GetCommentResponse>.from(json.decode(str).map((x) => GetCommentResponse.fromJson(x)));

String GetCommentResponseToJson(List<GetCommentResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCommentResponse {
  GetCommentResponse({
   required this.id,
   required this.post,
   required this.parent,
   required this.author,
   required this.authorName,
   required this.authorUrl,
   required this.date,
   required this.dateGmt,
   required this.content,
   required this.link,
   required this.status,
   required this.type,
   required this.authorAvatarUrls,
   required this.meta,
   required this.links,
  });

  int id;
  int post;
  int parent;
  int author;
  String authorName;
  String authorUrl;
  DateTime date;
  DateTime dateGmt;
  Content content;
  String link;
  String status;
  String type;
  Map<String, String> authorAvatarUrls;
  List<dynamic> meta;
  Links links;

  factory GetCommentResponse.fromJson(Map<String, dynamic> json) => GetCommentResponse(
    id: json["id"],
    post: json["post"],
    parent: json["parent"],
    author: json["author"],
    authorName: json["author_name"],
    authorUrl: json["author_url"],
    date: DateTime.parse(json["date"]),
    dateGmt: DateTime.parse(json["date_gmt"]),
    content: Content.fromJson(json["content"]),
    link: json["link"],
    status: json["status"],
    type: json["type"],
    authorAvatarUrls: Map.from(json["author_avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "parent": parent,
    "author": author,
    "author_name": authorName,
    "author_url": authorUrl,
    "date": date.toIso8601String(),
    "date_gmt": dateGmt.toIso8601String(),
    "content": content.toJson(),
    "link": link,
    "status": status,
    "type": type,
    "author_avatar_urls": Map.from(authorAvatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "_links": links.toJson(),
  };
}

class Content {
  Content({
    required this.rendered,
  });

  String rendered;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class Links {
  Links({
   required this.self,
   required this.collection,
   required this.author,
   required this.up,
  });

  List<Collection> self;
  List<Collection> collection;
  List<Author> author;
  List<Up> up;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
    up: List<Up>.from(json["up"].map((x) => Up.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "author": List<dynamic>.from(author.map((x) => x.toJson())),
    "up": List<dynamic>.from(up.map((x) => x.toJson())),
  };
}

class Author {
  Author({
   required this.embeddable,
   required this.href,
  });

  bool embeddable;
  String href;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

class Collection {
  Collection({
    required  this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Up {
  Up({
   required this.embeddable,
   required this.postType,
   required this.href,
  });

  bool embeddable;
  String postType;
  String href;

  factory Up.fromJson(Map<String, dynamic> json) => Up(
    embeddable: json["embeddable"],
    postType: json["post_type"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "post_type": postType,
    "href": href,
  };
}
