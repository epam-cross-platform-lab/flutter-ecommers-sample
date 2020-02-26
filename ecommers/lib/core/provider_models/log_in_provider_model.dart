import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/login_model.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';

class LogInProviderModel extends ProviderModelBase {

  LogInProviderModel(I18n localization) : super(localization);

  Future tryLogin(String username, String password) async {
    const String _usernameKey = 'username';
    const String _passwordKey = 'password';

    isBusy = true;

    final Response<LoginModel> response = await apiService.login({
      _usernameKey: username,
      _passwordKey: password,
    });

    isBusy = false;

    if (response.isSuccessful) {
      membershipService.refresh(response.body);
      await navigationService.navigateWithReplacementTo(Pages.shell);
    }
  }
}
