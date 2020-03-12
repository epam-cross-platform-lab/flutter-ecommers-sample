import 'package:ecommers/core/mixins/busy_notifier.dart';
import 'package:ecommers/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusyPage<T extends BusyNotifier> extends StatelessWidget {
  final Widget child;

  const BusyPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
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
    );
  }
}
