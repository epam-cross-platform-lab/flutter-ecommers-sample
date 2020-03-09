import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class DetailsTabWidget extends StatelessWidget {
  final ProductDetailsModel productDetailModel;

  const DetailsTabWidget({@required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final _localization = I18n.of(context);
    const _marginValue = 18.2;

    return Container(
      margin: const EdgeInsets.only(left: _marginValue, right: _marginValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _createDetailsListWidget(_localization.brand, _localization.sku, productDetailModel.brand, productDetailModel.sku),
          _createDetailsListWidget(_localization.condition, _localization.material, productDetailModel.condition, productDetailModel.material),
          _createDetailsListWidget(_localization.category, _localization.fitting, productDetailModel.category, productDetailModel.fitting),
        ],
      ),
    );
  }

  Widget _createDetailsListWidget(String titleLeft, String titleRight, String valueLeft, String valueRight) {
    const _verticalTitleSpaceHeight = 30.0;
    const _verticalValueSpaceHeight = 5.0;
    const _titleTextStile = TextStyle(
      fontSize: Insets.x4,
      color: BrandingColors.secondary,
    );
    const _valueTextStile = TextStyle(
      fontSize: Insets.x5,
      color: BrandingColors.secondary,
    );

    return Column(
      children: [
        const SizedBox(
          height: _verticalTitleSpaceHeight,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              titleLeft,
              style: _titleTextStile,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                titleRight,
                style: _titleTextStile,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: _verticalValueSpaceHeight,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              valueLeft,
              style: _valueTextStile,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                valueRight,
                style: _valueTextStile,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
