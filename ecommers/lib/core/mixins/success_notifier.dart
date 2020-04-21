import 'package:flutter/material.dart';

mixin SuccessNotifierMixin on ChangeNotifier {
  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  set isSuccess(bool isSuccess) {
    _isSuccess = isSuccess;
    notifyListeners();
  }
}
