import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:ecommers/extensions/string_extension.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';

@immutable
class RightMenuSubTitle extends StatelessWidget {
  final RightMenuItemModel model;

  const RightMenuSubTitle({@required this.model});

  @override
  Widget build(BuildContext context) {
    final modelItem = model.runtimeType;
    switch (modelItem) {
      case RightMenuSubTitleModel:
        return createSubTitle(context, model);
        break;
      case RigthMenuPriceModel:
        return createPrice(context, model);
        break;
      case RightMenuColorsModel:
        return createCircles(model);
        break;
      default:
        return const Text('');
    }
  }

  Widget createSubTitle(BuildContext context, RightMenuItemModel model) {
    final subTitleModel = model as RightMenuSubTitleModel;

    return Text(
      subTitleModel.subTitle,
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Colors.transparent.withOpacity(0.3),
          ),
    );
  }

  Widget createPrice(BuildContext context, RightMenuItemModel model) {
    final priceModel = model as RigthMenuPriceModel;

    return Text(
      '\$${priceModel.minPrice} - \$${priceModel.maxPrice}',
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Colors.transparent.withOpacity(0.3),
          ),
    );
  }

  Widget createCircles( RightMenuItemModel model) {
    final colorsModel = model as RightMenuColorsModel;
    final colors = colorsModel.colors;

    return Stack(
      children: colors
          .map((color) =>
              circleBuilder(color, colors.length - colors.indexOf(color)))
          .toList(),
    );
  }

  Widget circleBuilder(String color, int index) {
    return Container(
      width: Insets.x5,
      height: Insets.x5,
      margin: EdgeInsets.only(left: Insets.x3 * index),
      decoration: BoxDecoration(
        color: color.fromHexToColor(),
        shape: BoxShape.circle,
      ),
    );
  }
}
