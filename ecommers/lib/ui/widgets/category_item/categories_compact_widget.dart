import 'package:ecommers/common/categories.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/category_item.dart';
import 'package:flutter/material.dart';

class CategoriesCompactWidget extends StatelessWidget {
  static const _containerHeight = 134.0;
  final i18n = I18n.delegate;

  static const categoryItemSize = Size(74.0, 89.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _containerHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.x6,
      ),
      decoration: BoxDecoration(
        gradient: Gradients.categoriesCompact,
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Text(
            I18n.of(context).categoriesTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _createCategoriesListWidget(context),
          )
        ],
      ),
    );
  }

  Widget _createCategoriesListWidget(BuildContext context) {
    var itemCount = _calculateItemCount(context);
    var spacing = _calculateItemSpacing(context, itemCount);

    return SizedBox(
      height: categoryItemSize.height,
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: spacing,
          height: spacing,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == itemCount - 1 && index != Categories.values.length - 1) {
            return _buildSeeAllCategory(context);
          }

          return CategoryItem.fromType(Categories.values[index]);
        },
      ),
    );
  }

  Widget _buildSeeAllCategory(BuildContext context) {
    return CategoryItem(
      backgroundColor: BrandingColors.background,
      shadowColor: BrandingColors.blur,
      imagePath: ARROW_RIGHT_ICON,
      title: I18n.of(context).seeAllCategoryTitle,
    );
  }

  int _calculateItemCount(BuildContext context) {
    var categoriesListWidth =
        MediaQuery.of(context).size.width - Dimens.pagePadding * 2;

    var itemCount = categoriesListWidth ~/ categoryItemSize.width;

    itemCount = itemCount > Categories.values.length
        ? Categories.values.length
        : itemCount;

    return itemCount;
  }

  double _calculateItemSpacing(BuildContext context, int itemCount) {
    var categoriesListWidth =
        MediaQuery.of(context).size.width - Dimens.pagePadding * 2;

    var calculatedListSpacing =
        (categoriesListWidth % categoryItemSize.width) / (itemCount - 1);

    return calculatedListSpacing;
  }
}
