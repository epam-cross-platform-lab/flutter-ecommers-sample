import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/providers/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShellProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final i18n = I18n.delegate;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ecommers",
        theme: ThemeProvider.getTheme(),
        home: ShellPage(),
        localizationsDelegates: [i18n],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback:
            i18n.resolution(fallback: Locale("en", "US")));
  }
}


