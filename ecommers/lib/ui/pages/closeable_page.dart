import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CloseablePage extends StatelessWidget {
  final Widget child;

  CloseablePage({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              CLOSE_ICON,
              color: BrandingColors.primary,
              height: 18.0,
            ),
            onPressed: () => navigationService.goBack(),
          )
        ],
      ),
      body: child,
    );
  }
}
