import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

//TODO: move to provider
final List<AuthRichTextSpanModel> _bottomText = [
  AuthRichTextSpanModel(
    text: 'Don’t have an account? Swipe right to \n',
    isTappable: false,
  ),
  AuthRichTextSpanModel(
    text: 'create a new account.',
    isTappable: true,
    onTap: () => navigationService.navigateTo(Pages.shell),
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
    final localization = I18n.of(context);

    return AuthorizationTabBase(
      children: <Widget>[
        const SizedBox(height: Insets.x5),
        AuthTextFieldAreaContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AuthTextField(
                controller: usernameOrEmailController,
                labelText: localization.usernameOrEmail,
                keyboardType: TextInputType.emailAddress,
                assetIconPath: Assets.profileIcon,
              ),
              AuthTextField(
                controller: passwordController,
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
          text: localization.logIn,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () => logInButtonPressHandler(),
        ),
        const SizedBox(height: Insets.x8_5),
        AuthRichText(textSpanModelList: _bottomText),
      ],
    );
  }

  Future logInButtonPressHandler() async {
    final Response<LoginModel> response = await apiService.login({
      'username': usernameOrEmailController.text,
      'password': passwordController.text
    });

    if (response.isSuccessful) {
      membershipService.refresh(response.body);
      await navigationService.navigateWithReplacementTo(Pages.shell);
    } else {
      await showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          elevation: 10.0,
          title: Text('Alert'),
          content: Text('Username or password is incorrect (try: admin/admin)'),
        ),
      );
    }
  }
}
