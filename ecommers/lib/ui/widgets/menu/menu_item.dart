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
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Text(
            subTitle ?? '',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontWeight: FontWeight.w300),
          ),
          const SizedBox(width: 10.0),
          SvgPicture.asset(MENU_ARROW_ICON),
          const SizedBox(width: 15.0),
        ],
      ),
    );
  }
}
