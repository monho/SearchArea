import 'package:flutter/material.dart';
import 'package:searcharea/viewmodel/place/placeViewModel.dart';


class HomeViewModel with ChangeNotifier {
  String _searchQuery = '맘스터치';
  String _sortOption = '가까운 순';

  String get searchQuery => _searchQuery;
  String get sortOption => _sortOption;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSortOption(String? option, PlaceViewModel placeViewModel) {
    if (option != null) {
      _sortOption = option;
      if (_sortOption == '가까운 순') {
        placeViewModel.fetchPlaces(_searchQuery); // 거리순 정렬을 위해 다시 fetch
      }
      notifyListeners();
    }
  }
}