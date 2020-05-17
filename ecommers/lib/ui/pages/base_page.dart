import 'package:ecommers/core/mixins/busy_notifier.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage<T extends BusyNotifier> extends StatelessWidget {
  final Widget child;

  final T Function() createProvider;

  const BasePage({
    @required this.createProvider,
    this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (_) => createProvider(),
        child: BusyPage<T>(
    child: child,
        ),
      );
  }
}
