import 'package:ecommers/generated/i18n.dart';
import 'package:flutter/material.dart';

abstract class ProviderModelBase extends ChangeNotifier {
  final I18n localization;
  final BuildContext context;

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool isBusy) {
    _isBusy = isBusy;
    notifyListeners();
  }

  ProviderModelBase(this.context) : localization = I18n.of(context);
}
