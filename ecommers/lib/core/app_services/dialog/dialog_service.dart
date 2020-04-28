import 'package:ecommers/core/app_services/dialog/confirmation_dialog.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/widgets.dart';

import 'confirm_phone_registration.dart';

class DialogService {
  Future<bool> showDialog(
      {@required String header,
      @required String body,
      @required String confirmText,
      String declineText}) {
    return ConfirmationDialog().show(header, body, confirmText, declineText);
  }

  Future<String> confirmPhoneRegistration() {
    return ConfirmPhoneRegistration().showDialog();
  }

  Future<bool> somethingWentWrong() {
    return showDialog(
        header: localization.something_went_wrongTitle,
        body: localization.something_went_wrongDescription,
        confirmText: localization.something_went_wrongPrimary_button);
  }
}
