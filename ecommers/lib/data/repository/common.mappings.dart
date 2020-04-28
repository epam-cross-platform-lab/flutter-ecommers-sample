import 'package:ecommers/core/models/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AuthExt on AuthResult {
  LoginModel toLoginModel() {
    //firebase auth do not has tokens
    return LoginModel('token', 'refreshToken',
        DateTime.now().add(const Duration(days: 180)).toString());
  }
}
