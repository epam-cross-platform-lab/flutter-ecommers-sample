import 'package:flutter/material.dart';

class DialogManager {
  static Future showAlertDialog(
      BuildContext context, String title, String contentText) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 10.0,
        title: Text(title),
        content: Text(contentText),
      ),
    );
  }
}
