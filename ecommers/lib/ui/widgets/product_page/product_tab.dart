import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductTab extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final noInfoTextStyle = Theme.of(context).textTheme.subtitle1;

    return ChangeNotifierProvider(
      create: (_) => ProductTabProviderModel(colors, sizes),
      child: Consumer<ProductTabProviderModel>(
        builder: (context, ProductTabProviderModel model, child) {
          return ListView(
            children: [
              Text(
                localization.selectColor,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: Insets.x25,
                child: _createColorsList(noInfoTextStyle, model),
              ),
              Text(
                localization.selectSizeUs,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: Insets.x5),
              SizedBox(
                height: Insets.x12_5,
                child: _createSizesList(noInfoTextStyle, model),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _createSizesList(
      TextStyle noInfoTextStyle, ProductTabProviderModel model) {
    if (model.sizes?.isNotEmpty == true) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: model.sizes.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: Insets.x4_5),
        itemBuilder: (context, i) {
          final textSizeColor = model.sizes[i].isSelected
              ? BrandingColors.primary
              : BrandingColors.primaryText;

          return GestureDetector(
            onTap: () => _selectSize(i, model),
            child: Container(
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(Radiuses.big_1x)),
              ),
              child: Center(
                child: Text(
                  model.sizes[i].size ?? '-',
                  style: TextStyle(
                    fontSize: FontSizes.big_2x,
                    color: textSizeColor,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Center(
      child: Text(
        localization.noAvailableInformation,
        style: noInfoTextStyle,
      ),
    );
  }

  Widget _createColorsList(
      TextStyle noInfoTextStyle, ProductTabProviderModel model) {
    if (model.colors?.isNotEmpty == true) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: model.colors.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: Insets.x4_5),
        itemBuilder: (context, i) {
          final iconColor = model.colors[i].isSelected
              ? (Color(model.colors[i].color) == Colors.white
                  ? Colors.black
                  : Colors.white)
              : Colors.transparent;

          return GestureDetector(
            onTap: () => _selectColor(i, model),
            child: Container(
              width: Insets.x12_5,
              decoration: BoxDecoration(
                color: Color(model.colors[i].color),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: Radiuses.small_1x,
                    offset: Offset(Insets.x0, Insets.x0_5),
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

    return Center(
      child: Text(
        localization.noAvailableInformation,
        style: noInfoTextStyle,
      ),
    );
  }

  void _selectSize(int index, ProductTabProviderModel model) {
    model.selectSize(index);

    if (skuIdHasChanged != null) {
      skuIdHasChanged(
        ProductSkuIdModel(
          size: model.sizes[index].size,
          color: model.colors.firstWhere((color) => color.isSelected)?.color,
        ),
      );
    }
  }

  void _selectColor(int index, ProductTabProviderModel model) {
    model.selectColor(index);

    if (colorHasChanged != null) {
      colorHasChanged(model.colors[index].images);
    }

    if (skuIdHasChanged != null) {
      skuIdHasChanged(
        ProductSkuIdModel(
          size: model.sizes.firstWhere((size) => size.isSelected)?.size,
          color: model.colors[index].color,
        ),
      );
    }
  }
}
