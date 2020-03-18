import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/mixins/success_notifier.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProviderModel extends ProviderModelBase with SuccessNotifier{
  ForgotPasswordProviderModel(BuildContext context) : super(context);

  void sendPasswordToEmail() {
    isSuccess = true;
  }
}
