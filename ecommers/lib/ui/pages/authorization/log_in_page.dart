import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

final List<AuthRichTextSpanModel> _bottomText = [
  AuthRichTextSpanModel(
    text: 'Don’t have an account? Swipe right to \n',
    isTappable: false,
  ),
  AuthRichTextSpanModel(
    text: 'create a new account.',
    isTappable: true,
    onTap: () async => await navigationService.navigateTo(Pages.shell),
  ),
];

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController usernameOrEmailController;
  TextEditingController passwordController;

  @override
  void initState() {
    usernameOrEmailController = TextEditingController();
    passwordController = TextEditingController();
    
    super.initState();
  }

  @override
  void dispose() {
    usernameOrEmailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = I18n.of(context);

    return AuthorizationTabBase(
      children: <Widget>[
        SizedBox(height: Insets.x5),
        AuthTextFieldAreaContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AuthTextField(
                controller: usernameOrEmailController,
                labelText: localization.usernameOrEmail,
                keyboardType: TextInputType.emailAddress,
                assetIconPath: PROFILE_ICON,
              ),
              AuthTextField(
                controller: passwordController,
                labelText: localization.password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                assetIconPath: PASSWORD_ICON,
              ),
            ],
          ),
        ),
        SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: localization.logIn,
          assetIconPath: ARROW_RIGHT_ICON,
          onPressedFunction: () async => await logInButtonPressHandler(),
        ),
        SizedBox(height: Insets.x8_5),
        AuthRichText(textSpanModelList: _bottomText),
      ],
    );
  }

  Future logInButtonPressHandler() async {
    var adminCreds = 'admin';

    if (usernameOrEmailController.text == adminCreds &&
        passwordController.text == adminCreds)
      await navigationService.navigateWithReplacementTo(Pages.shell);
    else
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          elevation: 10.0,
          title: Text('Alert'),
          content: Text('Username or password is incorrect (try: admin/admin)'),
        ),
      );
  }
}
