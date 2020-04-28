import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessPage extends StatelessWidget {
  static const circleImageSize = Size(101.0, 101.0);

  const SuccessPage();

  @override
  Widget build(BuildContext context) {
    return CloseablePage(
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleImage(
                image: SvgPicture.asset(
                  Assets.successIcon,
                  fit: BoxFit.scaleDown,
                ),
                size: circleImageSize,
              ),
              const SizedBox(height: 28.0),
              Text('John Doe', //TODO from provider
                  style: textTheme.headline6),
              const SizedBox(height: 14.0),
              SizedBox(
                width: 252.0,
                child: Text(
                  localization.successMessage,
                  style: textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: 165.0,
                child: PrimaryButtonWidget(
                  text: 'MY ORDERS',
                  onPressedFunction: () {},
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
