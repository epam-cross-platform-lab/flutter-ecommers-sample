import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CachedImage extends StatelessWidget {
  final String imagePath;
  final BoxFit boxFit;

  const CachedImage({@required this.imagePath, this.boxFit = BoxFit.scaleDown});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${Assets.imageBaseUrl}/$imagePath',
      errorWidget: (context, url, error) =>
          SvgPicture.asset(Assets.warningIcon),
      fit: boxFit,
    );
  }
}
