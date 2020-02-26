import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: 'access_token')
  final String token;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  
  @JsonKey(name: 'expiration_date')
  final String expirationDate;

  LoginModel(this.token, this.refreshToken, this.expirationDate);

  static const fromJsonFactory = _$LoginModelFromJson;

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
