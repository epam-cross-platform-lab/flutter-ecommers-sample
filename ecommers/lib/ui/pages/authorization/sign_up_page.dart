import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/auth/sign_up_provider_model.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool _isPhoneSelected = false;

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProviderModel>(context, listen: false);

    final authForm = _isPhoneSelected
        ? _buildPhoneSignUp(provider)
        : _buildSignUpForm(provider);

    return AuthorizationTabBase(
      children: <Widget>[
        const SizedBox(height: Insets.x5),
        authForm,
        const SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: localization.signUp,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () => _onSignUpTapped(authForm, provider),
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

  AuthForm _buildPhoneSignUp(SignUpProviderModel provider) {
    return AuthForm(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AuthTextField(
            labelText: localization.your_phone_number,
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            prefixText: '+',
            controller: phoneController,
            onValidate: (text) => UserValidator.isPhoneNumber(text)
                ? null
                : localization.incorrect_phone_number,
            onChanged: (text) => provider.phoneNumber = phoneController.text,
          ),
          AuthTextField(
            labelText: localization.username,
            svgIconPath: Assets.profileIcon,
            onValidate: (text) => text.isEmpty ? localization.field_should_not_be_empty : null,
            onChanged: (text) => provider.username = phoneController.text,
          ),
        ],
      ),
    );
  }

  AuthForm _buildSignUpForm(SignUpProviderModel provider) {
    return AuthForm(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AuthTextField(
            labelText: localization.email,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            svgIconPath: Assets.mailIcon,
            onValidate: (text) =>
                UserValidator.isEmail(text) ? null : localization.emailError,
            onChanged: (text) => provider.email = emailController.text,
          ),
          AuthTextField(
            labelText: localization.username,
            controller: userNameController,
            svgIconPath: Assets.profileIcon,
            onValidate: (text) => text.isEmpty ? localization.field_should_not_be_empty : null,
            onChanged: (text) => provider.username = userNameController.text,
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
            onChanged: (text) => provider.password = passwordController.text,
          ),
        ],
      ),
    );
  }

  void _onSignUpTapped(AuthForm authForm, SignUpProviderModel provider) {
    if (!authForm.formKey.currentState.validate()) return;

    if (_isPhoneSelected) {
      provider.autorizeWithPhoneNumber();
    } else {
      provider.tryAuthorize();
    }
  }
}
