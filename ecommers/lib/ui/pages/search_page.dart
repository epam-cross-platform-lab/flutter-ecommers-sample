import 'package:ecommers/shared/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/search/index.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    return BasePage(
      createProvider: (context) => SearchPageProviderModel(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.x5),
          child: Column(
            children: <Widget>[
              Text(
                localization.searchTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: Insets.x5),
              SearchButton(
                onPressed: () =>
                    navigationService.navigateTo(Pages.productsGrid),
              ),
              const SizedBox(height: Insets.x5),
              const RecentProductList(),
              const SizedBox(height: Insets.x5),
              Consumer<SearchPageProviderModel>(
                builder: (_, provider, __) => ContainerWithAction(
                  title: localization.recommended,
                  actionText: localization.refresh,
                  action: provider.refreshRecommendedProducts,
                  child: SearchRecommendedWinget(
                      recommendedList: provider.recommendedProducts),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
