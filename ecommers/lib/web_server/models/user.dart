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

  User(this.username, this.email, this.password);

  static const fromJsonFactory = _$UserFromJson;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}