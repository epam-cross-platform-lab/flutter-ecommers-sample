import 'package:flutter/material.dart';

mixin BusyNotifier on ChangeNotifier {
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool isBusy) {
    _isBusy = isBusy;
    notifyListeners();
  }
}
