import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../ui/decorations/dimens/index.dart';
import '../../ui/decorations/index.dart';

class Progress extends StatelessWidget {
  static const double _progressSide = 40.0;
  static const double _containerSide = _progressSide + 30.0;

  const Progress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: _containerSide,
        width: _containerSide,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Radiuses.normal),
        ),
        child: const SizedBox(
          height: _progressSide,
          width: _progressSide,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(BrandingColors.primary),
          ),
        ),
      ),
    );
  }
}
