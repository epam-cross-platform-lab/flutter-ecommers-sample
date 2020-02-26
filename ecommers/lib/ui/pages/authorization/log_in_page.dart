import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/log_in_provider_model.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<LogInProviderModel>(context, listen: false);

    return Consumer<LogInProviderModel>(
      builder: (_, LogInProviderModel provider, child) {
        if (provider.isBusy) {
          return Container(
            color: Colors.red,
          );
        } else {
          return child;
        }
      },
      child: AuthorizationTabBase(
        children: <Widget>[
          const SizedBox(height: Insets.x5),
          AuthTextFieldAreaContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AuthTextField(
                  controller: usernameOrEmailController,
                  labelText: provider.localization.usernameOrEmail,
                  keyboardType: TextInputType.emailAddress,
                  assetIconPath: Assets.profileIcon,
                ),
                AuthTextField(
                  controller: passwordController,
                  labelText: provider.localization.password,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  assetIconPath: Assets.passwordIcon,
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.x3_5),
          PrimaryButtonWidget(
            text: provider.localization.logIn,
            assetIconPath: Assets.arrowRightIcon,
            onPressedFunction: () => provider.tryLogin(
                usernameOrEmailController.text, passwordController.text),
          ),
          const SizedBox(height: Insets.x8_5),
          AuthRichText(textSpanModelList: _bottomText),
        ],
      ),
    );
  }

  Future _showAlertDialog() async {
    const String alertContent =
        'Username or password is incorrect (try: admin/admin)';
    const String alertTitle = 'Увага';

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 10.0,
        title: const Text(alertTitle),
        content: const Text(alertContent),
        actions: <Widget>[
          CupertinoButton(
            onPressed: () {},
            child: const Text('ok'),
          )
        ],
      ),
    );
  }
}
