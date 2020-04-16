import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductTab extends StatefulWidget {
  final List<ProductColorModel> colors;
  final List<ProductSizeModel> sizes;
  final Function(List<CarouselImage>) colorHasChanged;
  final Function(ProductSkuIdModel) skuIdHasChanged;

  const ProductTab({
    Key key,
    @required this.colors,
    @required this.sizes,
    this.colorHasChanged,
    this.skuIdHasChanged,
  }) : super(key: key);

  @override
  _ProductTabState createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  List<ProductColorModel> colors;
  List<ProductSizeModel> sizes;

  @override
  void initState() {
    colors = widget.colors;
    sizes = widget.sizes;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization.selectColor,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 100,
          child: _createColorsList(localization),
        ),
        Text(
          localization.selectSizeUs,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        const SizedBox(height: Insets.x5),
        SizedBox(
          height: 50,
          child: _createSizesList(localization),
        ),
      ],
    );
  }

  Widget _createSizesList(I18n localization) {
    return sizes?.isNotEmpty == true
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: Insets.x4_5),
            itemBuilder: (context, i) {
              final textSizeColor = sizes[i].isSelected
                  ? BrandingColors.primary
                  : BrandingColors.primaryText;

              return GestureDetector(
                onTap: () => _selectSize(i),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Radiuses.big_1x)),
                  ),
                  child: Center(
                    child: Text(
                      sizes[i].size ?? '-',
                      style: TextStyle(
                        fontSize: FontSizes.big_2x,
                        color: textSizeColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              localization.noAvailableInformation,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
  }

  Widget _createColorsList(I18n localization) {
    return colors?.isNotEmpty == true
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: Insets.x4_5),
            itemBuilder: (context, i) {
              final iconColor = colors[i].isSelected
                  ? (Color(colors[i].color) == Colors.white
                      ? Colors.black
                      : Colors.white)
                  : Colors.transparent;

              return GestureDetector(
                onTap: () => _selectColor(i),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(colors[i].color),
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
          )
        : Center(
            child: Text(
              localization.noAvailableInformation,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
  }

  void _selectSize(int index) {
    setState(() => {
          sizes.forEach(_unselectSizes),
          sizes[index].isSelected = true,
        });

    if (widget.skuIdHasChanged != null) {
      widget.skuIdHasChanged(
        ProductSkuIdModel(
          size: sizes[index].size,
          color: colors.firstWhere((color) => color.isSelected)?.color,
        ),
      );
    }
  }

  void _selectColor(int index) {
    setState(() => {
          colors.forEach(_unselectColors),
          colors[index].isSelected = true,
          if (widget.colorHasChanged != null)
            {
              widget.colorHasChanged(colors[index].images),
            }
        });

    if (widget.skuIdHasChanged != null) {
      widget.skuIdHasChanged(
        ProductSkuIdModel(
          size: sizes.firstWhere((size) => size.isSelected)?.size,
          color: colors[index].color,
        ),
      );
    }
  }

  void _unselectSizes(ProductSizeModel size) {
    size.isSelected = false;
  }

  void _unselectColors(ProductColorModel color) {
    color.isSelected = false;
  }
}
