import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final Widget image;
  final Size size;

  const CircleImage({
    @required this.image,
    @required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: BrandingColors.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.x2),
        child: image,
      ),
    );
  }
}
