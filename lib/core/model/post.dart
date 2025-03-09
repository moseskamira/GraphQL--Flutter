import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String? id;
  String? title;
  String? body;
  String? createdAt;
  String? author;

  Post({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
