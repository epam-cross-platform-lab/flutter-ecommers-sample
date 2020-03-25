import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/provider_models/sign_up_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    final provider = Provider.of<SignUpProviderModel>(context, listen: false);

    final signUpForm = _buildSignUpForm(localization, provider);

    return AuthorizationTabBase(
      children: <Widget>[
        const SizedBox(height: Insets.x5),
        signUpForm,
        const SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: localization.signUp,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () {
            if (signUpForm.formKey.currentState.validate()) {
              provider.tryAuthorize();
            }
          },
        ),
        const SizedBox(height: Insets.x8_5),
        AuthRichText(textSpanModelList: provider.bottomText),
      ],
    );
  }

  AuthForm _buildSignUpForm(
      I18n localization, SignUpProviderModel provider) {
    return AuthForm(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AuthTextField(
            labelText: localization.email,
            keyboardType: TextInputType.emailAddress,
            assetIconPath: Assets.mailIcon,
            onValidate: (text) =>
                Validator.isEmail(text) ? null : localization.emailError,
            onChanged: (text) => provider.email = text,
          ),
          AuthTextField(
            labelText: localization.username,
            assetIconPath: Assets.profileIcon,
            onValidate: (text) => text.isEmpty ? localization.fieldError : null,
            onChanged: (text) => provider.username = text,
          ),
          AuthTextField(
            labelText: localization.password,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            assetIconPath: Assets.passwordIcon,
            onValidate: (text) => Validator.isPasswordValid(text)
                ? null
                : localization.passwordError,
            onChanged: (text) => provider.password = text,
          ),
        ],
      ),
    );
  }
}
