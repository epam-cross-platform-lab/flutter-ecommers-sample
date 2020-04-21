import 'package:ecommers/core/app_services/dialog/dialog_base.dart';
import 'package:flutter/material.dart';

class ConfirmPhoneRegistration extends DialogBase<String> {
  @override
  String get defaultValue => null;

  Future<String> showDialog() {
    final codeController = TextEditingController();

    return showInternally(AlertDialog(
      title: Text("Enter SMS Code"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(controller: codeController),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text("Done"),
          textColor: Colors.white,
          color: Colors.redAccent,
          onPressed: () => dismissDialog(codeController.text),
        )
      ],
    ));
  }
}
