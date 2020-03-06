import 'package:ecommers/core/provider_models/main_provider.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/authorization_page.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/progress.dart';
import 'package:ecommers/web_server/local_server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/provider_models/index.dart';

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
    return MaterialApp(
      title: 'ecommers',
      theme: ThemeProvider.getTheme(),
      home: FutureBuilder(
        future: MainProviderModel(context).initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return Container(
                color: BrandingColors.pageBackground,
                child: const Center(child: Progress()),
              );
            case ConnectionState.done:
            default:
              return membershipService.isNotExpired
                  ? ShellPage()
                  : const AuthorizationPage();
          }
        },
      ),
      navigatorKey: navigationService.navigatorKey,
      localizationsDelegates: [i18n],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(
        fallback: const Locale('en', 'US'),
      ),
    );
  }
}
