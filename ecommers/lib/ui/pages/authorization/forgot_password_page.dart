import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/authentication_tab_base.dart';
import 'package:ecommers/ui/widgets/authorization/auth_text_field_area_container.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);

    return AuthorizationTabBase(
      children: <Widget>[
        Text(
          localization.forgotPasswordHelpText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: Insets.x8_5),
        AuthTextFieldAreaContainer(
          child: AuthTextField(
            labelText: localization.email,
            keyboardType: TextInputType.emailAddress,
            assetIconPath: Assets.mailIcon,
          ),
        ),
        const SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: localization.logIn,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () {}, //TODO: add providers handler to it
        ),
      ],
    );
  }
}
