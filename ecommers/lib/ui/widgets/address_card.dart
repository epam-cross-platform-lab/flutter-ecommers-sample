import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

class AddressCard extends StatelessWidget {
  final ShippingAddressModel itemShippingAddress;
  final Function() deleteFunction;
  final Function() onTappedFunction;
  final Function() editFunction;
  final bool isSelect;

  const AddressCard({
    @required this.itemShippingAddress,
    this.deleteFunction,
    this.onTappedFunction,
    this.editFunction,
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
              height: 105,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemShippingAddress.fullName,
                          style: textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: FontSizes.big_1x),
                        ),
                        Text(
                          '${itemShippingAddress.country}, ${itemShippingAddress.city}',
                          style: textTheme.bodyText1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${itemShippingAddress.address}, ${itemShippingAddress.state}',
                          style: textTheme.bodyText2
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: editFunction,
                      child: Text(
                        localization.edit,
                        style: textTheme.headline4
                            .copyWith(color: BrandingColors.primary),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: deleteFunction,
                      child: Text(
                        localization.delete,
                        style: textTheme.headline4
                            .copyWith(color: BrandingColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildCircleIcon(isSelect)
      ],
    );
  }

  Widget _buildCircleIcon(bool isSelect) {
    if (!isSelect) return SizedBox(width: CircleIcon.size.width);

    return const CircleIcon(
      imagePath: Assets.successIcon,
      backgroundColor: BrandingColors.primary,
      iconColor: BrandingColors.secondaryText,
    );
  }
}
