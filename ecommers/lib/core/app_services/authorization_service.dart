import 'dart:async';

import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/data/repository/firebase_repository.dart';

class AuthorizationService {
  Future<AuthStatus> signInWithEmailAndPassword(
      String email, String password) async {
    final result = await FirebaseAuthRepository()
        .signInWithEmailAndPassword(email, password);

    if (result.status == AuthStatus.success) {
      membershipService.refresh(result.data);
    }

    return result.status;
  }

  Future<bool> updateUserName(String username) {
    return FirebaseAuthRepository().updateUsername(username);
  }

  Future<AuthStatus> signInWithPhone(String phone) async {
    final result = await FirebaseAuthRepository().signInWithPhoneNumber(phone);
    if (result.status == AuthStatus.success) {
      membershipService.refresh(result.data);
    }

    return result.status;
  }

  Future<AuthStatus> createUserWithEmailAndPassword(
      String email, String password) async {
    final result = await FirebaseAuthRepository()
        .registerWithEmailAndPassword(email, password);
    if (result.status == AuthStatus.success) {
      membershipService.refresh(result.data);
    }

    return result.status;
  }

  Future<bool> restorePassword(String email) async {
    return FirebaseAuthRepository().restorePassword(email);
  }

  Future logOut() async {
    membershipService.clear();
    await FirebaseAuthRepository().logout();
  }
}
