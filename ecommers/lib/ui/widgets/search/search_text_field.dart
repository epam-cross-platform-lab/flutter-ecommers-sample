import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputTextStyle = Theme.of(context).textTheme.subtitle1;

    final hintStyle = inputTextStyle.copyWith(
        color: BrandingColors.primaryText.withOpacity(0.4));

    final localization = I18n.of(context);
    return Container(
      height: 35.0,
      padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
      decoration: BoxDecoration(
        color: BrandingColors.background,
        borderRadius: BorderRadius.circular(Radiuses.big_1_5x),
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        style: inputTextStyle,
        decoration: InputDecoration(
          icon: const Icon(Icons.search), //TODO: get the correct 
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
    );
  }
}
