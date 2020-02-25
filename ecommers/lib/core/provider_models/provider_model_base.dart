import 'package:ecommers/generated/i18n.dart';
import 'package:flutter/material.dart';

abstract class ProviderModelBase extends ChangeNotifier {
  final I18n localization;

  bool _isBusy;

  bool get isBusy => _isBusy;

  set isBusy(bool isBusy) {
    _isBusy = isBusy;
    notifyListeners();
  }

  ProviderModelBase(this.localization);
}
