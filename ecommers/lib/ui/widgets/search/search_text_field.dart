import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputTextStyle = textTheme.subtitle1;

    final hintStyle = inputTextStyle.copyWith(
        color: BrandingColors.primaryText.withOpacity(0.4));

    return Container(
      height: 35.0,
      padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
      decoration: BoxDecoration(
        color: BrandingColors.background,
        borderRadius: BorderRadius.circular(Radiuses.big_1_5x),
      ),
      child: Builder(
        builder: (context) => TextField(
          textInputAction: TextInputAction.search,
          style: inputTextStyle,
          onChanged: (value) {
            final provider =
                Provider.of<SearchQueryProviderModel>(context, listen: false);

            provider.searchQuery = value;
          },
          decoration: InputDecoration(
            icon: SvgPicture.asset(Assets.searchIcon),
            hintText: localization.searchHintText,
            hintStyle: hintStyle,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusColor: inputTextStyle.color,
          ),
        ),
      ),
    );
  }
}
