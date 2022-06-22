
import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart';

@JsonSerializable()
class Picture {
  @JsonKey(name: 'medium', includeIfNull: false)
  final String? avatarUrl;

  Picture({
    this.avatarUrl
  });

  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);
}
