import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIcon extends StatelessWidget {
  static const size = Size(Insets.x4_5, Insets.x4_5);

  final String imagePath;
  final Color backgroundColor;
  final Color iconColor;

  const CircleIcon({
    this.imagePath = Assets.arrowIcon,
    this.backgroundColor = BrandingColors.backgroundIcon,
    this.iconColor = BrandingColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.x1),
              child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.scaleDown,
          color: iconColor,
        ),
      ),
    );
  }
}
