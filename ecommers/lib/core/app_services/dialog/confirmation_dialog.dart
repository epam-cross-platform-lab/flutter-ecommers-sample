import 'dart:async';

import 'package:ecommers/core/app_services/dialog/dialog_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmationDialog extends DialogBase<bool> {
  @override
  bool get defaultValue => false;

  Future<bool> show(String header, String body, String confirmText,
      String declineText) async {
    return showInternally(AlertDialog(
      title: Text(
        header,
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Text(body,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.start),
      actions: <Widget>[
        if (declineText?.isNotEmpty ?? false)
          FlatButton(
            onPressed: () => dismissDialog(false),
            child: Text(
              declineText,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        FlatButton(
          onPressed: () => dismissDialog(false),
          child: Text(
            confirmText,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    ));
  }
}
