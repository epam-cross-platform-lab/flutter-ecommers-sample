import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchTextFiled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 35.0,
            decoration: const BoxDecoration(
              color: BrandingColors.blur,
              borderRadius: BorderRadius.all(
                Radius.circular(Radiuses.big_1_5x),
              ),
            ),
            child: TextFormField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: I18n.of(context).searchHintText,
                hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: Insets.x25, end: Insets.x1),
                  child: Icon(
                    Icons.search,
                    size: FontSizes.normal,
                  ),
                ),
              ),
              onEditingComplete: () => {},

              //TODO pass value to provider
            ),
          ),
        ),
      ],
    );
  }
}
