import 'package:ecommers/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'ui/pages/index.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShellPage(),
        localizationsDelegates: [i18n],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback:
            i18n.resolution(fallback: Locale("en", "US")));
  }
}


