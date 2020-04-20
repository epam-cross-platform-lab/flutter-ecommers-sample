import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/extensions/index.dart';

class SearchRecommendedWinget extends StatelessWidget {
  final List<Product> recommendedList;

  const SearchRecommendedWinget({Key key, this.recommendedList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (recommendedList == null) return const SizedBox();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        spacing: Insets.x2_5,
        runSpacing: Insets.x2,
        children: _sortRecommendedList(context, recommendedList)
            .map((item) => createItem(item.title, context))
            .toList(),
      ),
    );
  }

  List<Product> _sortRecommendedList(
      BuildContext context, List<Product> products) {
    final contentWidgh = MediaQuery.of(context).size.width - 2 * Insets.x5;

    for (var i = 0; i < products.length; i++) {
      final Map<int, double> widths = {};
      final titleWidth = _textWidth(context, products[i].title);

      for (var j = i + 1; j < products.length; j++) {
        final subtitleWidth = _textWidth(context, products[j].title);
        final sumWidth = titleWidth + subtitleWidth + Insets.x2_5;
        if (sumWidth < contentWidgh) {
          widths.putIfAbsent(j, () => sumWidth);
        }
      }

      if (widths.isNotEmpty) {
        final movableProduct = products.removeAt(_getMaxWidthIndex(widths));
        products.insert(i + 1, movableProduct);
        i++;
      }
    }

    return products;
  }

  int _getMaxWidthIndex(Map<int, double> widths) {
    final sortedKeys = widths.keys.toList(growable: false)
      ..sort((k1, k2) => widths[k1].compareTo(widths[k2]));

    return sortedKeys.last;
  }

  double _textWidth(BuildContext context, String title) {
    final itemTextStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: FontSizes.small_3x, fontWeight: FontWeight.w400);

    return title.size(itemTextStyle).width + Insets.x5;
  }

  Widget createItem(String searchRecommendedItem, BuildContext context) {
    return InkWell(
      onTap: () => navigationService.navigateTo(Pages.product),
      child: Container(
        decoration: BoxDecoration(
          color: BrandingColors.background,
          borderRadius: BorderRadius.circular(Radiuses.small_1x),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.x2_5,
            vertical: Insets.x2,
          ),
          child: Text(
            searchRecommendedItem,
            overflow: TextOverflow.ellipsis,
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
