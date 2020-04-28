import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:ecommers/ui/widgets/search/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentProductList extends StatefulWidget {
  const RecentProductList({Key key}) : super(key: key);

  @override
  _RecentProductListState createState() => _RecentProductListState();
}

class _RecentProductListState extends State<RecentProductList> {
  @override
  Widget build(BuildContext context) {
    final searchProvider =
        Provider.of<SearchPageProviderModel>(context, listen: false);

    return Consumer<ShellProviderModel>(
      builder: (_, shellProvider, child) {
        if (shellProvider.selectedPage == Pages.search) {
          Future.microtask(() => searchProvider.updateRecentProducts());
        }
        return child;
      },
      child: Consumer<SearchPageProviderModel>(
        builder: (_, provider, __) => ContainerWithAction(
          title: localization.recentlyViewed,
          actionText: localization.clear,
          action: provider.clearRecentProducts,
          child:
              provider.recentProducts == null || provider.recentProducts.isEmpty
                  ? null
                  : SizedBox(
                      height: ProductItemSmall.size.height,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.recentProducts.length,
                        itemBuilder: (context, index) {
                          final product = provider.recentProducts[index];
                          return ProductItemSmall(product: product);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: Insets.x3),
                      ),
                    ),
        ),
      ),
    );
  }
}
