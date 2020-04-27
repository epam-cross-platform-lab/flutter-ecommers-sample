import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/mixins/success_notifier.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProviderModel extends ProviderModelBase
    with SuccessNotifierMixin {
  ForgotPasswordProviderModel(BuildContext context) : super(context);

  Future resetPassword(String email) async {
    isSuccess = await authorizationService.restorePassword(email);
  }
}
