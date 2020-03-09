import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/widgets/search/index.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 16,
                bottom: 16,
              ),
              child: Text(
                I18n.of(context).searchTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        SearchTextFiled(),
      ],
    );
  }

}