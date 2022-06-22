import 'package:json_annotation/json_annotation.dart';
import 'package:social_api/enums/gender.dart';
import 'package:social_api/models/name.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  final Gender? gender;
  final Name? name;
  final DateTime? dob;

  User({
    this.gender,
    this.name,
    this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Results {
  final List<User> results;

  Results(this.results);

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}
