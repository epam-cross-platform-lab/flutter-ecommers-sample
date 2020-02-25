import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';

class MainProviderModel extends ProviderModelBase {
  MainProviderModel(I18n localization) : super(localization);

  Future initialize() async {
    isBusy = true;
    await membershipService.load();
    isBusy = false;
  }
}
