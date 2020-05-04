import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class DialogBase<T> {
  Completer<T> _completer;

  T get defaultValue;

  @protected
  Future<T> showInternally(Widget body) {
    _completer = Completer<T>();
    _showDialog(body);
    return _completer.future;
  }

  @protected
  void _showDialog(Widget body) {
    Get.dialog(
        WillPopScope(
            onWillPop: () {
              dismissDialog(defaultValue);
              return Future.value(false);
            },
            child: body),
        barrierDismissible: true);
  }

  @protected
  void dismissDialog(T result) {
    Get.close(1);
    _trySetResult(result);
  }

  void _trySetResult(T result) {
    if (_completer != null) {
      _completer.complete(result);
      _completer = null;
    }
  }
}
