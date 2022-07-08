import 'package:json_annotation/json_annotation.dart';
import 'package:socail/modules/posts/models/picture.dart';
part 'categories.g.dart';
@JsonSerializable()
class Categories{
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'photos', includeIfNull: false)
  final List<Picture>? images;

  // String get imgurl => images![0].imgUrl ?? '';

  Categories({this.title,this.description,this.images});

  factory Categories.fromJson(Map<String,dynamic> json) => _$CategoriesFromJson(json);

  Map<String,dynamic> toJson() => _$CategoriesToJson(this);
}