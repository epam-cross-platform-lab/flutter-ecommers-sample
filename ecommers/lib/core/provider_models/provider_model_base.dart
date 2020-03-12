import 'package:ecommers/core/mixins/busy_notifier.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:flutter/material.dart';

abstract class ProviderModelBase extends ChangeNotifier with BusyNotifier {
  @protected
  final I18n localization;

  final BuildContext context;

  ProviderModelBase(this.context) : localization = I18n.of(context);
}
