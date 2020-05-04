import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider_models/index.dart';
import '../../ui/decorations/dimens/index.dart';
import '../../ui/pages/index.dart';
import '../../ui/widgets/category/categories_compact_view.dart';
import '../../ui/widgets/index.dart';

class HomePage extends StatelessWidget {
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      createProvider: () => HomeProviderModel(),
      child: Consumer<HomeProviderModel>(
        builder: (context, provider, child) {
          return CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CategoriesCompactView(provider.categoryList),
                    const SizedBox(height: Insets.x2),
                    NotesCarousel(notes: provider.notesLatest),
                  ],
                ),
              ),
              ProductLatestGrid(controller: _controller),
              child,
            ],
          );
        },
        child: const ItemsLoader<HomeProviderModel>(),
      ),
    );
  }
}
