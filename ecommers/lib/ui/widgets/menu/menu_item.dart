import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItem extends StatelessWidget {
  final String svgAssetIconPath;
  final String title;
  final String subTitle;
  final double height;
  final Function() onTap;

  const MenuItem({
    this.svgAssetIconPath,
    this.title,
    this.subTitle,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (svgAssetIconPath != null)
              SizedBox(
                width: 57.0,
                child: SvgPicture.asset(svgAssetIconPath),
              )
            else
              const SizedBox(width: 15.0),
            Expanded(
              child: Text(
                title ?? '',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Text(
              subTitle ?? '',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(width: 10.0),
            const CircleIcon(),
            const SizedBox(width: 15.0),
          ],
        ),
      ),
    );
  }
}
