import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CachedImage extends StatelessWidget {
  final String imagePath;
  final BoxFit boxFit;
  final String placeholder;

  const CachedImage({
    @required this.imagePath,
    this.boxFit = BoxFit.scaleDown,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: placeholder == null
          ? null
          : (_, __) => CachedNetworkImage(imageUrl: placeholder, fit: boxFit),
      imageUrl: imagePath,
      placeholderFadeInDuration: const Duration(seconds: 0),
      errorWidget: (context, url, error) =>
          SvgPicture.asset(Assets.warningIcon),
      fit: boxFit,
    );
  }
}
