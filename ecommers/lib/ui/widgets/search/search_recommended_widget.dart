import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SearchRecommendedWinget extends StatelessWidget {
  final List<Product> recommendedList;

  const SearchRecommendedWinget({Key key, this.recommendedList }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(recommendedList == null) return Container();
    return Wrap(
      spacing: Insets.x2_5,
      runSpacing: Insets.x2,
      children: recommendedList
          .map((item) => createItem(item.title, context))
          .toList(),
    );
  }

  Widget createItem(String searchRecommendedItem, BuildContext context) {
    return InkWell(
      onTap: () => navigationService.navigateTo(Pages.productsGrid),
      child: Container(
        decoration: BoxDecoration(
          color: BrandingColors.background,
          borderRadius: BorderRadius.circular(Radiuses.small_1x),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Insets.x2_5, vertical: Insets.x2),
          child: Text(
            searchRecommendedItem,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: FontSizes.small_3x,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}
