import 'dart:ui';

import 'package:ecommers/ui/decorations/index.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  static const String _animationState = 'loading';

  const Progress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: const Center(
        child: FlareActor(
          Assets.progressAnimation,
          alignment: Alignment.center,
          animation: _animationState,
        ),
      ),
    );
  }
}
