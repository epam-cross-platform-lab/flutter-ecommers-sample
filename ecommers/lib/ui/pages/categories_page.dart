import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/pages/base_page.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/widgets/backgrounded_safe_area.dart';
import 'package:ecommers/ui/widgets/category/category_item.dart';
import 'package:ecommers/ui/widgets/category/sub_category_list.dart';
import 'package:ecommers/ui/widgets/index.dart';

class CategoriesPage extends StatelessWidget {
  final List<Category> categories;

  const CategoriesPage({this.categories});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      createProvider: () => CategoriesProviderModel(categories),
      child: CloseablePage(
        child: BackgroundedSafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.fromLTRB(
              Insets.x5,
              0,
              Insets.x5,
              Insets.x5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  localization.allCategories,
                  style: textTheme.headline6,
                ),
                const SizedBox(height: Insets.x6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildCategories(),
                    const SizedBox(width: Insets.x6),
                    Flexible(child: SubCategoryList())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Consumer<CategoriesProviderModel>(
      builder: (_, provider, __) {
        return SizedBox(
          width: CategoryItem.size.width,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: Insets.x8,
              height: Insets.x8,
            ),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final categoryModel = categories[index];

              return CategoryItem(
                model: categoryModel,
                isSelected: index == provider.selectedCategoryIndex,
                onTapFunction: () => provider.selectedCategoryIndex = index,
              );
            },
          ),
        );
      },
    );
  }
}
