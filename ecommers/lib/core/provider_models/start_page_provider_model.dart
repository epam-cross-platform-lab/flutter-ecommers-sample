import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class StartPageProviderModel extends ChangeNotifier with BusyNotifier {
  bool get isAuthorized => membershipService.isNotExpired;
}
