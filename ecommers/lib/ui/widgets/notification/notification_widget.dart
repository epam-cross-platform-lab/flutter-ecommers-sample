import 'package:ecommers/ui/decorations/dimens/dimens.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationWidget extends StatelessWidget {
  final String orderNumberText;
  final String richText;
  final String usualText;
  final bool isCheckedItem;
  final Color shadowColor;
  final String imagePath;
  final Color backgroundColor;
  final String day;

  static const backgroundSize = Size(50, 50);

  const NotificationWidget({
    @required this.orderNumberText,
    @required this.richText,
    @required this.usualText,
    @required this.isCheckedItem,
    @required this.shadowColor,
    @required this.imagePath,
    @required this.backgroundColor,
    @required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: backgroundSize.height,
          width: backgroundSize.width,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    offset: Dimens.defaultBlurOffset,
                    blurRadius: Radiuses.normal),
              ]),
          child: Center(
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        const SizedBox(
          width: Insets.x5,
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
                text: 'Package from your order ',
                style: Theme.of(context).textTheme.bodyText2,
                children: <TextSpan>[
                  TextSpan(
                      text: orderNumberText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: BrandingColors.primary)),
                  TextSpan(
                      text: ' has ',
                      style: Theme.of(context).textTheme.bodyText2),
                  TextSpan(
                      text: richText,
                      style: Theme.of(context).textTheme.bodyText1)
                ]),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            day,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
