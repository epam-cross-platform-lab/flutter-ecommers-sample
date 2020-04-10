import 'package:flutter/material.dart';

class SearchProviderModel extends ChangeNotifier {
  String _searchQuery;

  String get searchQuery => _searchQuery;
  set searchQuery(String query) {
    if (_searchQuery == query) return;

    _searchQuery = query;

    notifyListeners();
  }
}
