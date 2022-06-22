import 'package:json_annotation/json_annotation.dart';
import 'package:social_api/enums/gender.dart';
import 'package:social_api/models/name.dart';
import 'package:social_api/models/picture.dart';

part 'random_user.g.dart';

@JsonSerializable()
class RandomUser {
  final Gender? gender;
  final Name? name;
  final String? email;
  final Picture? picture;
  // final DateTime? dob;

  RandomUser({
    this.gender,
    this.name,
    this.email,
    this.picture,
  });

  factory RandomUser.fromJson(Map<String, dynamic> json) => _$RandomUserFromJson(json);

  String get displayName => name?.displayName ?? '';

  String get avatarUrl => picture?.avatarUrl ?? '';
}