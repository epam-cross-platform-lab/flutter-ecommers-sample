import 'dart:ui';

import 'package:ecommers/core/mixins/success_notifier.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessStatePage<T extends SuccessNotifier> extends StatelessWidget {
  final Widget child;

  const SuccessStatePage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const animationState = 'Check';
    const animationSize = 200.0;

    return Consumer<T>(
      builder: (_, provider, child) {
        return Visibility(
          visible: provider.isSuccess,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: Insets.x1_5, sigmaY: Insets.x1_5),
            child: Center(
              child: SizedBox(
                height: animationSize,
                width: animationSize,
                child: FlareActor(
                  Assets.successAnimation,
                  alignment: Alignment.center,
                  animation: animationState,
                  callback: (arg) => {
                    provider.isSuccess = false,
                  },
                ),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
