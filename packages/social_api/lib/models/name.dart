import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

@JsonSerializable()
class Name {
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;

  @JsonKey(name: 'first', includeIfNull: false)
  final String? first;

  @JsonKey(name: 'last', includeIfNull: false)
  final String? last;

  Name({
    this.title,
    this.first,
    this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  String get displayName => [title ?? '',first ?? '', last ?? ''].join(' ').trim();
}
