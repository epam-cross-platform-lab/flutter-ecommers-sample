import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/auth/log_in_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPhoneSelected = false;

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LogInProviderModel>(context, listen: false);

    final loginForm = _isPhoneSelected
        ? _buildPhoneForm(provider)
        : _buildEmailForm(provider);

    return AuthorizationTabBase(
      children: <Widget>[
        const SizedBox(height: Insets.x5),
        loginForm,
        const SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: localization.logIn,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () => _onLoginPressed(loginForm, provider),
        ),
        FlatButton(
          onPressed: () => setState(() => _isPhoneSelected = !_isPhoneSelected),
          child: Text(
            _isPhoneSelected
                ? localization.or_use_email
                : localization.or_use_phone,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: BrandingColors.primary),
          ),
        ),
        const SizedBox(height: Insets.x8_5),
        AuthRichText(textSpanModelList: provider.bottomText),
      ],
    );
  }

  AuthForm _buildPhoneForm(LogInProviderModel provider) {
    return AuthForm(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AuthTextField(
            prefixText: '+',
            labelText: localization.your_phone_number,
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            controller: phoneController,
            onValidate: (text) => UserValidator.isPhoneNumber(text)
                ? null
                : localization.incorrect_phone_number,
            onChanged: (String text) =>
                provider.phoneNumber = phoneController.text,
          ),
        ],
      ),
    );
  }

  AuthForm _buildEmailForm(LogInProviderModel provider) {
    return AuthForm(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AuthTextField(
            labelText: localization.usernameOrEmail,
            keyboardType: TextInputType.emailAddress,
            svgIconPath: Assets.profileIcon,
            controller: emailController,
            onValidate: (text) =>
                text.isEmpty ? localization.field_should_not_be_empty : null,
            onChanged: (String text) =>
                provider.userName = emailController.text,
          ),
          AuthTextField(
            labelText: localization.password,
            obscureText: true,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            svgIconPath: Assets.passwordIcon,
            onValidate: (text) => UserValidator.isPasswordValid(text)
                ? null
                : localization.passwordError,
            onChanged: (String text) =>
                provider.password = passwordController.text,
          ),
        ],
      ),
    );
  }

  void _onLoginPressed(AuthForm form, LogInProviderModel provider) {
    if (!form.formKey.currentState.validate()) return;

    if (_isPhoneSelected) {
      provider.phoneLogin();
    } else {
      provider.login();
    }
  }
}
