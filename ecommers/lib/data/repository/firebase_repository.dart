import 'dart:async';

import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/data/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'common.mappings.dart';

class FirebaseAuthRepository {
  Future<Result<LoginModel, AuthStatus>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return Result.submit(result.toLoginModel(), AuthStatus.success);
    } on PlatformException catch (ex) {
      logger.ex(ex);
      return Result.submit(null, AuthStatus.verificationFailed);
    } on Exception catch (ex) {
      logger.ex(ex);
      return Result.submit(null, AuthStatus.unknown);
    }
  }

  Future<Result<LoginModel, AuthStatus>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Result.submit(result.toLoginModel(), AuthStatus.success);
    } on PlatformException catch (ex) {
      logger.ex(ex);
      return Result.submit(null, AuthStatus.verificationFailed);
    } on Exception catch (ex) {
      logger.ex(ex);
      return Result.submit(null, AuthStatus.unknown);
    }
  }

  Future<Result<LoginModel, AuthStatus>> signInWithPhoneNumber(String phone) {
    final completer = Completer<Result<LoginModel, AuthStatus>>();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (AuthCredential cr) {},
        verificationFailed: (AuthException exception) {
          return null;
        },
        codeSent: (verificationId, [int codeSent]) async {
          final code = await dialogService.confirmPhoneRegistration();
          completer.complete(await _applyCode(verificationId, code));
        },
        codeAutoRetrievalTimeout: (str) {
          return null;
        });

    return completer.future;
  }

  Future<Result<LoginModel, AuthStatus>> _applyCode(
      String verificationId, String code) async {
    final smsCode = code.trim();

    final credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      final model =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return Result.submit(model.toLoginModel(), AuthStatus.success);
    } on Exception catch (ex) {
      logger.ex(ex);
      return Result.submit(null, AuthStatus.success);
    }
  }

  Future<bool> updateUsername(String username) async {
    try {
      final profileInfo = UserUpdateInfo()..displayName = username;
      (await FirebaseAuth.instance.currentUser())?.updateProfile(profileInfo);
      return true;
    } on PlatformException catch (ex) {
      logger.ex(ex);
      return false;
    } on Exception catch (ex) {
      logger.ex(ex);
      return false;
    }
  }

  Future<bool> restorePassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on Exception catch (ex) {
      logger.ex(ex);
      return false;
    }
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (ex) {
      logger.ex(ex);
      return false;
    }
  }
}

enum AuthStatus { success, timeout, verificationFailed, unknown }
