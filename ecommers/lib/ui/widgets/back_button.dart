import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        Assets.backIcon,
        color: BrandingColors.primary,
        height: Insets.x4_5,
      ),
      onPressed: () => navigationService.goBack(),
    );
  }
}