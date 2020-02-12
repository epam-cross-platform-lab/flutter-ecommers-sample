import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/authorization_page.dart';
import 'package:flutter/material.dart';

void main() {
  DependencyService.registerDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final i18n = I18n.delegate;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ecommers",
        theme: ThemeProvider.getTheme(), 
        home: AuthorizationPage(),
        navigatorKey: navigationService.navigatorKey,
        localizationsDelegates: [i18n],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback:
            i18n.resolution(fallback: Locale("en", "US")));
  }
}
