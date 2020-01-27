import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItem extends StatelessWidget {
  static const double _height = 48.0;

  final String svgAssetIconPath;
  final String title;
  final String subTitle;

  MenuItem({
    this.svgAssetIconPath,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 57.0,
            child: SvgPicture.asset(svgAssetIconPath),
          ),
          Expanded(
            child: Text(
              title ?? '',
              style: Styles.menuItemText,
            ),
          ),
          Text(
            subTitle ?? '',
            style: Styles.menuItemSubText,
          ),
          SizedBox(width: 10.0),
          SvgPicture.asset(MENU_ARROW_ICON),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }
}