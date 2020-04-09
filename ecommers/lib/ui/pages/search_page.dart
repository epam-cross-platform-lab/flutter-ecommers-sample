import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/recently_viewed_widget/index.dart';
import 'package:ecommers/ui/widgets/search/index.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const double recentlyViewedHeight = 56.0;
  static const double recommendedWiHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.x5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  localization.searchTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            const SizedBox(height: Insets.x5),
            SearchButton(onPressed:() => navigationService.navigateTo(Pages.productsGrid)),
            const SizedBox(height: Insets.x5),
            Row(
              children: <Widget>[
                Text(
                  localization.recentlyViewed,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: FontSizes.small_3x,
                        color: Colors.transparent.withOpacity(0.3),
                      ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => {}, //TODO: handle click
                  child: Text(
                    localization.clear,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: FontSizes.small_3x,
                        color: BrandingColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Insets.x5),
            Container(
              height: recentlyViewedHeight,
              child: RecentlyViewedWidget(),
            ),
            const SizedBox(height: Insets.x5),
            Row(
              children: <Widget>[
                Text(
                  localization.recommended,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: FontSizes.small_3x,
                        color: Colors.transparent.withOpacity(0.3),
                      ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => {}, //TODO: handle click
                  child: Text(
                    localization.refresh,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: FontSizes.small_3x,
                        color: BrandingColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Insets.x5),
            Container(
              height: 75.0,
              child: SearchRecommendedWinget(),
            ),
          ],
        ),
      ),
    );
  }
}
