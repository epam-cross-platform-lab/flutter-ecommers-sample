import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/home_provider_model.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesCompactWidget extends StatelessWidget {
  static const _containerHeight = 134.0;
  static const categoryItemSize = Size(74.0, 89.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _containerHeight,
      padding: const EdgeInsets.symmetric(horizontal: Insets.x6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              I18n.of(context).categoriesTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _createCategoriesListWidget(context),
        ],
      ),
    );
  }

  Widget _createCategoriesListWidget(BuildContext context) {
    final categoryList = Provider.of<HomeProviderModel>(context)?.categoryList;

    if (categoryList == null || categoryList.isEmpty) return const SizedBox();

    final itemCount = _calculateItemCount(context, categoryList.length);
    final spacing = _calculateItemSpacing(context, itemCount);

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
          if (index == itemCount - 1 && index != categoryList.length - 1) {
            return _buildSeeAllCategory(context);
          }

          return CategoryItem.fromModel(categoryList[index], onCategoryTap);
        },
      ),
    );
  }

  void onCategoryTap(Categories type) {
    navigationService.navigateTo(Pages.productsGrid, arguments: type);
  }

  Widget _buildSeeAllCategory(BuildContext context) {
    return CategoryItem(
      backgroundColor: BrandingColors.background,
      shadowColor: BrandingColors.blur,
      imagePath: Assets.arrowRightIcon,
      title: I18n.of(context).seeAllCategoryTitle,
      onTapFunction: () => navigationService.navigateTo(Pages.categories),
    );
  }

  int _calculateItemCount(BuildContext context, int categoriesCount) {
    final categoriesListWidth =
        MediaQuery.of(context).size.width - Dimens.pagePadding * 2;

    var itemCount = categoriesListWidth ~/ categoryItemSize.width;

    if (itemCount > categoriesCount) {
      itemCount = categoriesCount;
    } else {
      itemCount = itemCount;
    }

    return itemCount;
  }

  double _calculateItemSpacing(BuildContext context, int itemCount) {
    final categoriesListWidth =
        MediaQuery.of(context).size.width - Dimens.pagePadding * 2;

    final calculatedListSpacing =
        (categoriesListWidth % categoryItemSize.width) / (itemCount - 1);

    return calculatedListSpacing;
  }
}
