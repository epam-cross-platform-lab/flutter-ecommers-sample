import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String avatar;
  final String address;

  User(
    this.username,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.avatar,
    this.address,
  );

  static const fromJsonFactory = _$UserFromJson;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
