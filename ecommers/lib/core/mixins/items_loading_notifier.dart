import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ecommers/core/app_services/index.dart';
import 'package:ecommers/shared/dependency_service.dart' as services;

mixin ItemsLoadingNotifier on ChangeNotifier {
  @protected
  final Paginator paginator = services.paginator;

  bool _hasDisposed = false;
  bool _isItemsLoading = false;

  bool get isItemsLoading => _isItemsLoading;
  bool get hasMoreItems => paginator.hasMore;

  set isItemsLoading(bool isitemsLoading) {
    _isItemsLoading = isitemsLoading;

    if (!_hasDisposed) notifyListeners();
  }

  FutureOr<void> loadMoreProducts() {}

  @override
  void dispose() {
    _hasDisposed = true;
    super.dispose();
  }
}
