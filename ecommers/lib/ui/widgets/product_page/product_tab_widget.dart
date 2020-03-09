import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductTabWidget extends StatefulWidget {
  final List<ProductColorModel> colors;
  final List<ProductSizeModel> sizes;

  const ProductTabWidget({
    Key key,
    @required this.colors,
    @required this.sizes,
  }) : super(key: key);

  @override
  _ProductTabWidgetState createState() => _ProductTabWidgetState();
}

class _ProductTabWidgetState extends State<ProductTabWidget> {
  @override
  Widget build(BuildContext context) {
    final _localization = I18n.of(context);
    const _marginValue = 18.2;
    const _colorsListHeight = 100.0;
    const _colorHeight = 50.0;
    const _sizesListHeight = 50.0;
    const _sizesBoxWidth = 80.0;
    const _sizesBoxCornerRadius = BorderRadius.all(Radius.circular(15.0));
    const _verticalSpaceHeight = 20.0;
    const _colorIconSize = 15.0;

    return Container(
      margin: const EdgeInsets.only(left: _marginValue, right: _marginValue),
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
            child: _createColorsList(
              _marginValue,
              _colorHeight,
              _colorIconSize,
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
            child: _createSizesList(_marginValue, _sizesListHeight,
                _sizesBoxWidth, _sizesBoxCornerRadius),
          ),
        ],
      ),
    );
  }

  Widget _createSizesList(double marginValue, double sizesListHeight,
      double sizesBoxWidth, BorderRadiusGeometry sizesBoxCornerRadius) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.sizes.length,
      itemBuilder: (context, i) {
        final textSizeColor = widget.sizes[i].isSelected
                ? BrandingColors.primary
                : BrandingColors.primaryText;

        return GestureDetector(
          onTap: () => {
            setState(() => {
                  widget.sizes.forEach((item) => item.isSelected = false),
                  widget.sizes[i].isSelected = true,
                }),
          },
          child: Container(
            margin: i != 0
                ? EdgeInsets.only(left: marginValue, right: 0)
                : const EdgeInsets.only(left: 0, right: 0),
            height: sizesListHeight,
            width: sizesBoxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: sizesBoxCornerRadius,
            ),
            child: Center(
              child: Text(
                widget.sizes[i].size,
                style: TextStyle(
                  fontSize: Insets.x5,
                  color: textSizeColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _createColorsList(
      double marginValue, double _colorHeight, double colorIconSize) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.colors.length,
      itemBuilder: (context, i) {
        final iconColor = widget.colors[i].isSelected
            ? (Color(widget.colors[i].color) == Colors.white
                ? Colors.black
                : Colors.white)
            : Colors.transparent;

        return GestureDetector(
          onTap: () => {
            setState(() => {
                  widget.colors.forEach((item) => item.isSelected = false),
                  widget.colors[i].isSelected = true,
                }),
          },
          child: Container(
            margin: i != 0
                ? EdgeInsets.only(left: marginValue, right: 0)
                : const EdgeInsets.only(left: 0, right: 0),
            height: _colorHeight,
            width: _colorHeight,
            decoration: BoxDecoration(
              color: Color(widget.colors[i].color),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: Radiuses.normal,
                  offset: const Offset(Insets.x0, Insets.x0_5),
                  color: Colors.grey,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.successIcon,
                height: colorIconSize,
                color: iconColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
