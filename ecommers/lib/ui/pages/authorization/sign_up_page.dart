import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

// TODO: move to provider
final List<AuthRichTextSpanModel> _bottomText = [
  AuthRichTextSpanModel(
    text: 'By creating an account, you agree to our Privacy Policy \n',
    isTappable: false,
  ),
  AuthRichTextSpanModel(
    text: 'Terms of Service',
    isTappable: true,
    onTap: () => navigationService.navigateTo(Pages.shell),
  ),
  AuthRichTextSpanModel(
    text: ' and ',
    isTappable: false,
  ),
  AuthRichTextSpanModel(
    text: 'Privacy Policy',
    isTappable: true,
    onTap: () => navigationService.navigateTo(Pages.categories),
  ),
];

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);

    return AuthorizationTabBase(
      children: <Widget>[
        const SizedBox(height: Insets.x5),
        AuthTextFieldAreaContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AuthTextField(
                labelText: localization.email,
                keyboardType: TextInputType.emailAddress,
                assetIconPath: Assets.mailIcon,
              ),
              AuthTextField(
                labelText: localization.username,
                assetIconPath: Assets.profileIcon,
              ),
              AuthTextField(
                labelText: localization.password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                assetIconPath: Assets.passwordIcon,
              ),
            ],
          ),
        ),
        const SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: localization.signUp,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () {},
        ),
        const SizedBox(height: Insets.x8_5),
        AuthRichText(textSpanModelList: _bottomText),
      ],
    );
  }
}
