import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class DialogManager {
  static Future showAlertDialog(
      BuildContext context, String title, String contentText) async {
    final localization = I18n.of(context);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 10.0,
        title: Text(title),
        content: Text(contentText),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              localization.ok,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .apply(color: BrandingColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
