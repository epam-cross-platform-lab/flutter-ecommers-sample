import 'dart:async';

import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/web_server/local_server.dart';

import 'core/common/index.dart';
import 'core/models/data_models/index.dart';
import 'core/provider_models/index.dart';

List<Product> products;

void main() {
  runApp(MainApp());
  DependencyService.registerDependencies();
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final GeneratedLocalizationsDelegate i18n = I18n.delegate;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    LocalServer.setup();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      LocalServer.setup();
    } else if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      LocalServer.closeConnection();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShellProviderModel(context)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'ecommers',
        theme: ThemeProvider.getTheme(),
        home: SplashScreen.callback(
          name: Assets.splashLoader,
          onSuccess: (_) => membershipService.isNotExpired
              ? navigationService.navigateWithReplacementTo(Pages.shell)
              : navigationService.navigateWithReplacementTo(Pages.authorization),
          onError: null,
          until: () => Future.delayed(const Duration()),
          startAnimation: '1',
        ),
        navigatorKey: navigationService.navigatorKey,
        localizationsDelegates: [i18n],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback: i18n.resolution(
          fallback: const Locale('en', 'US'),
        ),
      ),
    );
  }
}
