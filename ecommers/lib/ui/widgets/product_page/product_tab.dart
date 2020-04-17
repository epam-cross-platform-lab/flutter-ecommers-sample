import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/generated/i18n.dart';
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
    final localization = I18n.of(context);
    return ChangeNotifierProvider(
      create: (_) => ProductTabProviderModel(
        colors,
        sizes,
        context: context,
      ),
      child: Consumer<ProductTabProviderModel>(
        builder: (context, ProductTabProviderModel model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.selectColor,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 100,
                child: _createColorsList(context, model, localization),
              ),
              Text(
                localization.selectSizeUs,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: Insets.x5),
              SizedBox(
                height: 50,
                child: _createSizesList(context, model, localization),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _createSizesList(
      BuildContext context, ProductTabProviderModel model, I18n localization) {
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.all(Radius.circular(Radiuses.big_1x)),
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
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _createColorsList(
      BuildContext context, ProductTabProviderModel model, I18n localization) {
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
              width: 50,
              decoration: BoxDecoration(
                color: Color(model.colors[i].color),
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

    return Center(
      child: Text(
        localization.noAvailableInformation,
        style: Theme.of(context).textTheme.subtitle1,
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
