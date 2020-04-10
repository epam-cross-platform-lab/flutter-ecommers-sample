import 'package:flutter/material.dart';

mixin BusyNotifier on ChangeNotifier {
  bool _hasDisposed = false;
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool isBusy) {
    _isBusy = isBusy;

    if (!_hasDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _hasDisposed = true;
    super.dispose();
  }
}
