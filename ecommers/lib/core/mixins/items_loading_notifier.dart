import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ecommers/core/app_services/index.dart';
import 'package:ecommers/core/services/dependency_service.dart' as services;

mixin ItemsLoadingNotifier on ChangeNotifier {
  @protected
  final Paginator paginator = services.paginator;

  bool _hasDisposed = false;
  bool _isitemsLoading = false;

  bool get isitemsLoading => _isitemsLoading;
  bool get hasMoreItems => paginator.hasMore;

  set isitemsLoading(bool isitemsLoading) {
    _isitemsLoading = isitemsLoading;

    if (!_hasDisposed) notifyListeners();
  }

  FutureOr<void> loadMoreProducts() {}

  @override
  void dispose() {
    _hasDisposed = true;
    super.dispose();
  }
}
