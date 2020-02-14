import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class BackgroundedSafeArea extends StatelessWidget {
  final Widget child;
  final bool isBottom;

  const BackgroundedSafeArea({
    Key key,
    this.child,
    this.isBottom = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BrandingColors.pageBackground,
      child: SafeArea(bottom: isBottom, child: child),
    );
  }
}
