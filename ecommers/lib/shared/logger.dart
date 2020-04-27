import 'package:ecommers/shared/app_logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Logger {
  final _appLogger = AppLogger();
  final _remoteLogger = Crashlytics.instance;

  /// Log a message at level [Level.verbose].
  void v(String Function() message) {
    _logInternally(Level.verbose, message);
  }

  /// Log a message at level [Level.debug].
  void d(String Function() message) {
    _logInternally(Level.debug, message);
  }

  /// Log a message at level [Level.info].
  void i(String Function() message) {
    _logInternally(Level.info, message);
  }

  /// Log a message at level [Level.warning].
  void w(String Function() message) {
    _logInternally(Level.warning, message);
  }

  /// Log a message at level [Level.error].
  void e(String Function() message) {
    _logInternally(Level.error, message);
  }

  /// Log a message at level [Level.error].
  void ex(dynamic ex, {StackTrace stackTrace}) {
    _logException(ex, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(String Function() message) {
    _logInternally(Level.wtf, message);
  }

  void _logInternally(Level level, String Function() message) {
    _appLogger.log(level, message);
  }

  void _logException(dynamic ex, StackTrace stack) {
    if (!kReleaseMode) {
      Crashlytics.instance.enableInDevMode = true;
      _remoteLogger.recordError(ex, StackTrace.current);
    }
  }
}
