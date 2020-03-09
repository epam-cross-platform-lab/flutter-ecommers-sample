import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class MainProviderModel extends ProviderModelBase {
  MainProviderModel(BuildContext context) : super(context);

  Future initialize() async {
    isBusy = true;
    await membershipService.load();
    isBusy = false;
  }
}
