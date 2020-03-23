import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'avatar')
  final String avatar;

  @JsonKey(name: 'address')
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
