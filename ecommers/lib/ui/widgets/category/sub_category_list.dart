import 'package:ecommers/core/models/page_arguments.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:ecommers/ui/widgets/index.dart';

class SubCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProviderModel>(
      builder: (_, provider, child) {
        final category = provider.selectedCategory;
        final subCategories = category.subCategories;

        return SurfaceContainer(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subCategories.length,
            padding: const EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              return MenuItem(
                title: subCategories[index],
                height: 44.0,
                onTap: () =>
                    onSubCategoryTap(category.type, subCategories[index]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: BrandingColors.secondary.withOpacity(0.1),
                height: 1.0,
                indent: 17.0,
                endIndent: 17.0,
                thickness: 1,
              );
            },
          ),
        );
      },
    );
  }

  void onSubCategoryTap(Categories type, String subCategory) {
    navigationService.navigateTo(
      Pages.productsGrid,
      arguments: PageArguments(arg1: type, arg2: subCategory),
    );
  }
}
