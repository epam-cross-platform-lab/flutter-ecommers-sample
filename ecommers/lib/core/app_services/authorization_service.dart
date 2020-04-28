import 'dart:async';

import 'package:ecommers/data/repository/firebase_repository.dart';
import 'package:ecommers/shared/dependency_service.dart';

class AuthorizationService {
  Future<AuthStatus> signInWithEmailAndPassword(
      String email, String password) async {
    final result =
        await authRepository.signInWithEmailAndPassword(email, password);

    if (result.status == AuthStatus.success) {
      membershipService.refresh(result.data);
    }

    return result.status;
  }

  Future<bool> updateUserName(String username) {
    return authRepository.updateUsername(username);
  }

  Future<AuthStatus> signInWithPhone(String phone) async {
    final result = await authRepository.signInWithPhoneNumber(phone);
    if (result.status == AuthStatus.success) {
      membershipService.refresh(result.data);
    }

    return result.status;
  }

  Future<AuthStatus> createUserWithEmailAndPassword(
      String email, String password) async {
    final result =
        await authRepository.registerWithEmailAndPassword(email, password);
    if (result.status == AuthStatus.success) {
      membershipService.refresh(result.data);
    }

    return result.status;
  }

  Future<bool> restorePassword(String email) async {
    return authRepository.restorePassword(email);
  }

  Future logOut() async {
    membershipService.clear();
    await authRepository.logout();
  }
}
