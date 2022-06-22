
import 'package:json_annotation/json_annotation.dart';
import 'package:socail/modules/posts/models/photo.dart';
import 'package:socail/modules/posts/models/picture.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;

  @JsonKey(name: 'status', includeIfNull: false)
  final int? status;

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'images', includeIfNull: false)
  final List<Picture>? images;

  @JsonKey(name: 'photos', includeIfNull: false)
  final List<Photo>? photos;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Post({
    this.id,
    this.status,
    this.title,
    this.description,
    this.images,
    this.photos,
  });

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
