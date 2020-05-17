import 'dart:async';

import 'package:ecommers/setup/ecommerce.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';


void main() {
  DependencyService.registerDependencies();
  runZonedGuarded(() => runApp(Ecommerce()),
      (ex, stackTrace) => logger.ex(ex, stackTrace: stackTrace));
}
