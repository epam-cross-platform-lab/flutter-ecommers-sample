import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'email')
  final String email;
  
  @JsonKey(name: 'password')
  final String password;

  UserModel(this.username, this.email, this.password);

  static const fromJsonFactory = _$UserModelFromJson;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}