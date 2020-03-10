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
    const _titleTextStyle = TextStyle(
      fontSize: Insets.x4,
      color: BrandingColors.secondary,
    );
    final _localization = I18n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Insets.x5),
        Text(
          _localization.selectColor,
          style: _titleTextStyle,
        ),
        SizedBox(
          height: 100,
          child: _createColorsList(),
        ),
        Text(
          _localization.selectSizeUs,
          style: _titleTextStyle,
        ),
        const SizedBox(height: Insets.x5),
        SizedBox(
          height: 50,
          child: _createSizesList(),
        ),
      ],
    );
  }

  Widget _createSizesList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.sizes.length,
      separatorBuilder: (context, index) => SizedBox(width: Insets.x4_5),
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
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(Radiuses.big_1x)),
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

  Widget _createColorsList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.colors.length,
      separatorBuilder: (context, index) => SizedBox(width: Insets.x4_5),
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
            width: 50,
            decoration: BoxDecoration(
              color: Color(widget.colors[i].color),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: Radiuses.small_1x,
                  offset: const Offset(Insets.x0, Insets.x0_5),
                  color: Colors.grey,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.successIcon,
                height: Insets.x4,
                color: iconColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
