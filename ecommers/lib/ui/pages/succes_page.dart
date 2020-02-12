import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccesPage extends StatelessWidget {
  const SuccesPage();
  static const circleLabelSize = Size(101.0, 101.0);
  @override
  Widget build(BuildContext context) {
    return CloseablePage(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 108.0),
            CircleLabel(
              image: SvgPicture.asset(
                SUCCES_ICON,
                fit: BoxFit.scaleDown,
              ),
              size: circleLabelSize,
            ),
            const SizedBox(height: 28.0),
            Text(
              'John Doe', //TODO from provider
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 30.0),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              width: 252.0,
              child: Text(
                'Your order was placed successfully. For more details, check All My Orders page under Profile tab',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50.0),
            SizedBox(
                width: 165.0,
                child: PrimaryButtonWidget(
                  text: 'MY ORDERS',
                  onPressedFunction: (){},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
