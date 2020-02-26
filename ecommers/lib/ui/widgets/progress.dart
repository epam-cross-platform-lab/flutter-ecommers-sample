import 'package:ecommers/ui/decorations/index.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  const Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  static const String animationState = '0to100';
  static const size = Size(50, 50);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: const FlareActor(
        Assets.progressAnimation,
        alignment: Alignment.center,
        animation: animationState,
      ),
    );
  }
}
