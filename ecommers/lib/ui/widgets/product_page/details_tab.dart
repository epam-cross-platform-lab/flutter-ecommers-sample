import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class DetailsTab extends StatelessWidget {
  final ProductDetails productDetailModel;
  final String skuId;

  const DetailsTab({
    @required this.productDetailModel,
    @required this.skuId,
  });

  @override
  Widget build(BuildContext context) {
    final detailsValues =
        _generateDetailsValues(productDetailModel, skuId);

    return GridView.builder(
      itemCount: detailsValues.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3),
      itemBuilder: (BuildContext context, int index) {
        final key = detailsValues.keys.toList()[index];
        if (index % 2 == 0) {
          return _createTileWidget(
              context, key, detailsValues[key], Alignment.topLeft);
        } else {
          return _createTileWidget(
              context, key, detailsValues[key], Alignment.topRight);
        }
      },
    );
  }

  Map<String, String> _generateDetailsValues(ProductDetails productDetailModel, String skuId) {
    final values = <String, String>{};

    if (productDetailModel?.brand?.isNotEmpty == true) {
      values.putIfAbsent(localization.brand, () => productDetailModel.brand);
    }
    if (skuId?.isNotEmpty == true) {
      values.putIfAbsent(localization.sku, () => skuId);
    }
    if (productDetailModel?.condition?.isNotEmpty == true) {
      values.putIfAbsent(
          localization.condition, () => productDetailModel.condition);
    }
    if (productDetailModel?.material?.isNotEmpty == true) {
      values.putIfAbsent(
          localization.material, () => productDetailModel.material);
    }
    if (productDetailModel?.category?.isNotEmpty == true) {
      values.putIfAbsent(
          localization.category, () => productDetailModel.category);
    }
    if (productDetailModel?.fitting?.isNotEmpty == true) {
      values.putIfAbsent(
          localization.fitting, () => productDetailModel.fitting);
    }

    return values;
  }

  Widget _createTileWidget(BuildContext context, String title, String value,
      AlignmentGeometry alignment) {
    return Column(
      children: [
        Align(
          alignment: alignment,
          child: Text(
            title,
            style: textTheme.subtitle2,
          ),
        ),
        Flexible(
          child: Align(
            alignment: alignment,
            child: Text(
              value,
              style: textTheme.subtitle2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
