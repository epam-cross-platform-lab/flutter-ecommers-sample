import 'package:flutter/material.dart';

import 'index.dart';

class HeroImage extends StatelessWidget {
  final String imagePath;
  final String placeholder;
  final BoxFit boxFit;
  final dynamic tag;

  const HeroImage({
    @required this.imagePath,
    this.tag,
    this.boxFit = BoxFit.scaleDown,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? imagePath,
      child: CachedImage(
        placeholder: placeholder,
        imagePath: imagePath,
        boxFit: boxFit,
      ),
    );
  }
}
