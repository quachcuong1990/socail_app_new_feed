// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duongdan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuongDan _$DuongDanFromJson(Map<String, dynamic> json) => DuongDan(
      linkHome: json['linkHome'] as String?,
      linkHelp: json['linkHelp'] as String?,
      linkPolicy: json['linkPolicy'] as String?,
      linkZalo: json['linkZalo'] as String?,
    );

Map<String, dynamic> _$DuongDanToJson(DuongDan instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('linkHome', instance.linkHome);
  writeNotNull('linkHelp', instance.linkHelp);
  writeNotNull('linkPolicy', instance.linkPolicy);
  writeNotNull('linkZalo', instance.linkZalo);
  return val;
}
