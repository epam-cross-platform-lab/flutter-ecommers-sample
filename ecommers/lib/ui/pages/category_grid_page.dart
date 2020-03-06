import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryGridPage extends StatelessWidget {
  final Categories type;

  const CategoryGridPage({this.type, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = CategoryGridProviderModel(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => categoryProvider),
      ],
      child: Consumer<CategoryGridProviderModel>(
        builder: (_, CategoryGridProviderModel provider, child) {
          return Stack(
            children: <Widget>[
              child,
              const Progress(),
            ],
          );
        },
        child: _buildChild(context, categoryProvider),
      ),
    );
  }

  Widget _buildChild(BuildContext context, CategoryGridProviderModel provider) {
    //final data = Provider.of<List<ProductModel>>(context);

    // return FutureProvider(
    //   create: (_) => provider.getData(type),

    // );

    return null == null
        ? Container(color: Colors.black)
        : Container(color: Colors.red);
  }
}
