import 'dart:ui';

import 'package:ecommers/ui/decorations/index.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  static const size = Size(100, 100);
  static const String _animationState = '0to100';

  const Progress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = _buildProgress();

    if (!kReleaseMode) {
      return progress;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: progress,
    );
  }

  Widget _buildProgress() {
    return Center(
      child: SizedBox.fromSize(
        size: size,
        child: const FlareActor(
          Assets.progressAnimation,
          alignment: Alignment.center,
          animation: _animationState,
        ),
      ),
    );
  }
}
