import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/forgot_password_page.dart';
import 'package:ecommers/ui/pages/authorization/log_in_page.dart';
import 'package:ecommers/ui/pages/authorization/sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabStyle = Theme.of(context).textTheme.headline6;
    final localization = I18n.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: BrandingColors.pageBackground,
        appBar: AppBar(
          backgroundColor: BrandingColors.pageBackground,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: localization.signUp),
              Tab(text: localization.logIn),
              Tab(text: localization.forgotPassword),
            ],
            indicatorColor: Colors.transparent,
            labelStyle: tabStyle,
            labelColor: tabStyle.color,
            unselectedLabelColor: tabStyle.color.withOpacity(0.2),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SignUpPage(),
            LogInPage(),
            ForgotPasswordPage(),
          ],
        ),
      ),
    );
  }
}
