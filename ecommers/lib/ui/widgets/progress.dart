import 'dart:ui';

import 'package:ecommers/ui/decorations/index.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  static const double _progressSide = 400.0;
  static const String _animationState = 'Loading';

  const Progress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = _buildProgress();

    if (!kReleaseMode) {
      return progress;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: _buildProgress(),
    );
  }

  Widget _buildProgress() {
    return const Center(
      child: SizedBox(
        height: _progressSide,
        width: _progressSide,
        child: FlareActor(
          Assets.progressAnimation,
          alignment: Alignment.center,
          animation: _animationState,
        ),
      ),
    );
  }
}
