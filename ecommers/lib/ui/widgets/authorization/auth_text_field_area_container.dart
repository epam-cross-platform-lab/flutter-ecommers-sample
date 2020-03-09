import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class AuthTextFieldAreaContainer extends StatelessWidget {
  final Widget child;

  const AuthTextFieldAreaContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radiuses.normal),
        color: BrandingColors.background,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Dimens.defaultBlurOffset,
            blurRadius: Radiuses.big_1x,
            color: BrandingColors.blur,
          )
        ],
      ),
      child: child,
    );
  }
}