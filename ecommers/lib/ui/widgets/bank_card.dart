import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter_svg/svg.dart';

class BankCard extends StatelessWidget {
  final String lastFourNumber;
  final Function() deleteFunction;
  final Function() onTappedFunction;
  final bool isSelect;

  const BankCard({
    @required this.lastFourNumber,
    this.deleteFunction,
    this.onTappedFunction,
    this.isSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: onTappedFunction,
            child: SurfaceContainer(
              padding: const EdgeInsets.fromLTRB(
                  Insets.x6, Insets.x4, Insets.x4, Insets.x4),
              height: 100.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(Assets.bankCard),
                        const SizedBox(width: Insets.x6_5),
                        Text(
                          Formatter.getTextWithNumberCard(lastFourNumber),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: deleteFunction,
                      child: Text(
                        I18n.of(context).delete,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: BrandingColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: Insets.x4),
        _buildCircleIcon(isSelect)
      ],
    );
  }

  Widget _buildCircleIcon(bool isSelect) {
    if (!isSelect) return SizedBox(width: CircleIcon.size.width);

    return CircleIcon(
      imagePath: Assets.successIcon,
      backgroundColor: BrandingColors.primary,
      iconColor: BrandingColors.secondaryText,
    );
  }
}
