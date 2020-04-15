import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/mixins/items_loading_notifier.dart';
import 'package:ecommers/ui/decorations/index.dart';

class ItemsLoader<T extends ItemsLoadingNotifier> extends StatelessWidget {
  static const loaderHeight = 60.0;

  const ItemsLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<T, bool>(
      builder: (_, isLoading, child) {
        return isLoading
            ? SliverToBoxAdapter(
                child: Container(
                  height: loaderHeight,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(BrandingColors.primary),
                  ),
                ),
              )
            : const SliverToBoxAdapter(
                child: SizedBox(height: loaderHeight),
              );
      },
      selector: (_, provider) => provider.isitemsLoading,
    );
  }
}
