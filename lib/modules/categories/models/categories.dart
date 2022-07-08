import 'package:json_annotation/json_annotation.dart';
import 'package:socail/modules/posts/models/picture.dart';
part 'categories.g.dart';
@JsonSerializable()
class Categories{
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'image', includeIfNull: false)
  final List<Picture>? image;

  Categories({this.description,this.image});

  factory Categories.fromJson(Map<String,dynamic> json) => _$CategoriesFromJson(json);

  Map<String,dynamic> toJson() => _$CategoriesToJson(this);
}