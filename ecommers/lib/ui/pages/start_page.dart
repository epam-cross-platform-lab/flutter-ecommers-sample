import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/provider_models/start_page_provider_model.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  static const route = '/start';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StartPageProviderModel(),
      child: Consumer<StartPageProviderModel>(
        builder: (context, StartPageProviderModel model, child) {
          return model.isAuthorized
              ? MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => ShellProviderModel()),
                    ChangeNotifierProvider(
                        create: (_) => PaymentMethodProviderModel()),
                    ChangeNotifierProvider(create: (_) => CartProvider()),
                  ],
                  child: ShellPage(),
                )
              : const AuthorizationPage();
        },
      ),
    );
  }
}
