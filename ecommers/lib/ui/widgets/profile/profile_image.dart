import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double profileCardHeight;

  const ProfileImage(this.profileCardHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: profileCardHeight,
      width: profileCardHeight,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              '${Assets.imageBaseUrl}/${Assets.girlImage}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
