import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class ProductTabWidget extends StatelessWidget {
  const ProductTabWidget();

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final _colors = [
      Colors.pink,
      Colors.orange,
      Colors.blue,
      Colors.white,
      Colors.grey,
      Colors.black,
      Colors.green,
      Colors.yellow
    ];
    final _sizes = ['4.5', '5.0', '6.0', '6.5', '7.0', '7.5', '8.0'];
    final _localization = I18n.of(context);
    const _marginvalue = 18.2;
    const _colorsListHeight = 100.0;
    const _colorHeight = 50.0;
    const _sizesListHeight = 50.0;
    const _sizesBoxWidth = 80.0;
    const _sizesBoxCornerRadius = BorderRadius.all(Radius.circular(15.0));
    const _verticalSpaceHeight = 20.0;

    return Container(
      margin: const EdgeInsets.only(left: _marginvalue, right: _marginvalue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: _verticalSpaceHeight,
          ),
          Text(
            _localization.selectColor,
            style: const TextStyle(
              fontSize: Insets.x4,
              color: BrandingColors.secondary,
            ),
          ),
          Container(
            height: _colorsListHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _colors.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: i != 0
                      ? const EdgeInsets.only(left: _marginvalue, right: 0)
                      : const EdgeInsets.only(left: 0, right: 0),
                  height: _colorHeight,
                  width: _colorHeight,
                  decoration: BoxDecoration(
                    color: _colors[i],
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          Text(
            _localization.selectSizeUs,
            style: const TextStyle(
              fontSize: Insets.x4,
              color: BrandingColors.secondary,
            ),
          ),
          const SizedBox(
            height: _verticalSpaceHeight,
          ),
          Container(
            height: _sizesListHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sizes.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: i != 0
                      ? const EdgeInsets.only(left: _marginvalue, right: 0)
                      : const EdgeInsets.only(left: 0, right: 0),
                  height: _sizesListHeight,
                  width: _sizesBoxWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: _sizesBoxCornerRadius,
                  ),
                  child: Center(
                    child: Text(
                      _sizes[i],
                      style: const TextStyle(
                        fontSize: Insets.x5,
                        color: BrandingColors.primaryText,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
