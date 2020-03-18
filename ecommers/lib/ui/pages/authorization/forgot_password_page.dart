import 'dart:ui';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/authentication_tab_base.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    final forgotPasswordForm = _buildForgotPasswordForm(localization);
    final provider =
        Provider.of<ForgotPasswordProviderModel>(context, listen: false);

    return Stack(
      children: <Widget>[
        AuthorizationTabBase(
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
              onPressedFunction: () {
                if (forgotPasswordForm.formKey.currentState.validate()) {
                  provider.sendPasswordToEmail();
                }
              }, //TODO: add providers handler to it
            ),
          ],
        ),
        const SuccessStatePage<ForgotPasswordProviderModel>(),
      ],
    );
  }

  AuthForm _buildForgotPasswordForm(I18n localization) {
    return AuthForm(
      child: AuthTextField(
        labelText: localization.email,
        keyboardType: TextInputType.emailAddress,
        assetIconPath: Assets.mailIcon,
        onValidate: (text) =>
            Validator.isEmail(text) ? null : localization.emailError,
      ),
    );
  }
}
