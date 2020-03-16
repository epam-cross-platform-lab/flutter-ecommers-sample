import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/search_recommended_widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchRecommendedWinget extends StatelessWidget {
  final List<SearchRecommendedItemModel> recommendedList = [
    const SearchRecommendedItemModel(titile: 'Denim Jeans'),
    const SearchRecommendedItemModel(titile: 'Mini Skirt'),
    const SearchRecommendedItemModel(titile: 'Jacket'),
    const SearchRecommendedItemModel(titile: 'Accessoires'),
    const SearchRecommendedItemModel(titile: 'Sports Accessoires'),
    const SearchRecommendedItemModel(titile: 'Yoga Pants'),
    const SearchRecommendedItemModel(titile: 'Eye Shadow'),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        spacing: Insets.x2_5,
        runSpacing: Insets.x2,
        children: recommendedList
            .map((item) => createItem(item.titile, context))
            .toList(),
      ),
    );
  }

  Widget createItem(String searchRecommendedItem, BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: BrandingColors.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.x2),
        child: InkWell(
          child: Text(
            searchRecommendedItem,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
          ),
          onTap: () => {}, //TODO:
        ),
      ),
    );
  }
}
