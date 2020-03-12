import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:flutter/material.dart';

class DetailsTab extends StatelessWidget {
  final ProductDetailsModel productDetailModel;

  const DetailsTab({@required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    final _localization = I18n.of(context);

    return Column(
      children: [
        _createDetailsListWidget(
          context,
          _localization.brand,
          _localization.sku,
          productDetailModel.brand,
          productDetailModel.sku,
        ),
        const SizedBox(height: Insets.x7_5),
        _createDetailsListWidget(
          context,
          _localization.condition,
          _localization.material,
          productDetailModel.condition,
          productDetailModel.material,
        ),
        const SizedBox(height: Insets.x7_5),
        _createDetailsListWidget(
          context,
          _localization.category,
          _localization.fitting,
          productDetailModel.category,
          productDetailModel.fitting,
        ),
      ],
    );
  }

  Widget _createDetailsListWidget(
    BuildContext context,
    String titleLeft,
    String titleRight,
    String valueLeft,
    String valueRight,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleLeft,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              titleRight,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        const SizedBox(height: Insets.x1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: Insets.x1),
                child: Text(
                  valueLeft,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Flexible(
                child: Text(
                  valueRight,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
            ),
          ],
        ),
      ],
    );
  }
}
