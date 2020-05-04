import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String username;

  final String email;
  
  UserModel(this.username, this.email);
}