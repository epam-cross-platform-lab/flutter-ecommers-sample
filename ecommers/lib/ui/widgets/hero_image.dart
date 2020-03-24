import 'package:flutter/material.dart';

import 'index.dart';

class HeroImage extends StatelessWidget {
  final String imagePath;
  final BoxFit boxFit;

  const HeroImage ({@required this.imagePath, this.boxFit = BoxFit.scaleDown});

  @override
  Widget build(BuildContext context) {
    return  Hero(
        tag: imagePath,
        child: CachedImage(
           imagePath: imagePath,
           boxFit: boxFit,
        ),
      );
  }
}