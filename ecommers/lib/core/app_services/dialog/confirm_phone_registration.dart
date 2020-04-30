import 'package:ecommers/core/app_services/dialog/dialog_base.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class ConfirmPhoneRegistration extends DialogBase<String> {
  @override
  String get defaultValue => null;

  Future<String> showDialog() {
    final codeController = TextEditingController();

    return showInternally(AlertDialog(
      title: Text(
        localization.enter_sms_code_dialogTitle,
        style: textTheme.headline5,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(controller: codeController),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          color: BrandingColors.primary,
          onPressed: () => dismissDialog(codeController.text),
          child: Text(localization.enter_sms_code_dialogPrimary_button),
        )
      ],
    ));
  }
}
