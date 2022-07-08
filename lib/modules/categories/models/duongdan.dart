import 'package:json_annotation/json_annotation.dart';
part 'duongdan.g.dart';
@JsonSerializable()
class DuongDan{
  @JsonKey(name: 'linkHome', includeIfNull: false)
  final String? linkHome;

  @JsonKey(name: 'linkHelp', includeIfNull: false)
  final String? linkHelp;

  @JsonKey(name: 'linkPolicy', includeIfNull: false)
  final String? linkPolicy;

  @JsonKey(name: 'linkZalo', includeIfNull: false)
  final String? linkZalo;
  factory DuongDan.fromJson(Map<String, dynamic> json) => _$DuongDanFromJson(json);


  DuongDan({this.linkHome, this.linkHelp, this.linkPolicy, this.linkZalo});

  Map<String, dynamic> toJson() => _$DuongDanToJson(this);


}