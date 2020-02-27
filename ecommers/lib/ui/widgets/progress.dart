import 'dart:ui';

import 'package:ecommers/ui/decorations/index.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  static const size = Size(70, 70);
  static const String _animationState = '0to100';

  const Progress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Progress.size,
        child: const FlareActor(
          Assets.progressAnimation,
          alignment: Alignment.center,
          animation: _animationState,
        ),
      ),
    );
  }
}
