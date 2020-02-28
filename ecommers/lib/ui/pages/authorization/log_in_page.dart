import 'package:ecommers/core/provider_models/log_in_provider_model.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/widgets/authorization/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LogInProviderModel>(
      builder: (_, LogInProviderModel provider, child) {
        return Stack(
          children: <Widget>[
            child,
            Visibility(
              visible: provider.isBusy,
              child: const Progress(),
            ),
          ],
        );
      },
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final provider = Provider.of<LogInProviderModel>(context, listen: false);

    return AuthorizationTabBase(
      children: <Widget>[
        const SizedBox(height: Insets.x5),
        AuthTextFieldAreaContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AuthTextField(
                labelText: provider.localization.usernameOrEmail,
                keyboardType: TextInputType.emailAddress,
                assetIconPath: Assets.profileIcon,
                onChanged: (String text) => provider.username = text,
              ),
              AuthTextField(
                labelText: provider.localization.password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                assetIconPath: Assets.passwordIcon,
                onChanged: (String text) => provider.password = text,
              ),
            ],
          ),
        ),
        const SizedBox(height: Insets.x3_5),
        PrimaryButtonWidget(
          text: provider.localization.logIn,
          assetIconPath: Assets.arrowRightIcon,
          onPressedFunction: () => provider.tryLogin(),
        ),
        const SizedBox(height: Insets.x8_5),
        AuthRichText(textSpanModelList: provider.bottomText),
      ],
    );
  }
}
