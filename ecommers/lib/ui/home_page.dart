import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).homePageTitle),
      ),
      body: CategoriesCompactWidget(),
    );
  }

}