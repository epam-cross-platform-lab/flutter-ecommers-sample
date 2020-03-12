import 'package:ecommers/core/mixins/busy_notifier.dart';
import 'package:ecommers/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage<T extends BusyNotifier> extends StatelessWidget {
  final Widget child;

  final T Function(BuildContext) createProvider;

  const BasePage({this.createProvider, this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => createProvider(context),
      child: Consumer<T>(
        builder: (_, provider, child) {
          return Stack(
            children: <Widget>[
              child,
              Visibility(
                visible: provider.isBusy,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Progress(),
                ),
              )
            ],
          );
        },
        child: child,
      ),
    );
  }
}
