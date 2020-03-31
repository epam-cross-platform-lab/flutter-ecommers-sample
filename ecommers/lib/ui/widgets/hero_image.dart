import 'package:flutter/material.dart';

import 'index.dart';

class HeroImage extends StatelessWidget {
  final String imagePath;
  final BoxFit boxFit;
  final int tag;

  const HeroImage({
    @required this.imagePath,
    this.tag,
    this.boxFit = BoxFit.scaleDown,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag : tag,
      child: CachedImage(
        imagePath: imagePath,
        boxFit: boxFit,
      ),
    );
  }
}
