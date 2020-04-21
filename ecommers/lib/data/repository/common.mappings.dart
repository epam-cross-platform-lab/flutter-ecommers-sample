import 'package:ecommers/core/models/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AuthExt on AuthResult {
  LoginModel toLoginModel() {
    return LoginModel('token', 'refreshToken',
        DateTime.now().add(const Duration(days: 180)).toString());
  }
}
