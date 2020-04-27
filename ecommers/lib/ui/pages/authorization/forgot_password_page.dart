import 'dart:ui';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/auth/forgot_password_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/authentication_tab_base.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    final forgotPasswordForm = _buildForgotPasswordForm(localization);
    final provider =
        Provider.of<ForgotPasswordProviderModel>(context, listen: false);

    return SuccessStatePage<ForgotPasswordProviderModel>(
      child: AuthorizationTabBase(
        children: <Widget>[
          Text(
            localization.forgotPasswordHelpText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: Insets.x8_5),
          forgotPasswordForm,
          const SizedBox(height: Insets.x3_5),
          PrimaryButtonWidget(
            text: localization.logIn,
            assetIconPath: Assets.arrowRightIcon,
            onPressedFunction: () =>
                _forgotPasswordRapped(forgotPasswordForm, provider),
          ),
        ],
      ),
    );
  }

  AuthForm _buildForgotPasswordForm(I18n localization) {
    return AuthForm(
      child: AuthTextField(
        controller: emailController,
        labelText: localization.email,
        keyboardType: TextInputType.emailAddress,
        svgIconPath: Assets.mailIcon,
        onValidate: (text) =>
            UserValidator.isEmail(text) ? null : localization.emailError,
      ),
    );
  }

  void _forgotPasswordRapped(
      AuthForm authForm, ForgotPasswordProviderModel provider) {
    if (authForm.formKey.currentState.validate()) {
      provider.resetPassword(emailController.text);
    }
  }
}
