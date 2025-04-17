import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String _searchQuery = '';
  String _sortOption = '가까운 순';
  int _currentIndex = 0;
  String get searchQuery => _searchQuery;
  String get sortOption => _sortOption;
  int get currentIndex => _currentIndex;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSortOption(String? option) {
    if (option != null) {
      _sortOption = option;
      notifyListeners();
    }
  }
}
