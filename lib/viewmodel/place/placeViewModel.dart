import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:searcharea/core/api_service.dart';
import 'package:searcharea/model/place/place_model.dart';

class PlaceViewModel with ChangeNotifier {
  final NaverApiService _naverApiService = NaverApiService();
  List<Place> _places = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Place> get places => _places;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchPlaces(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _places = await _naverApiService.fetchPlaces(query);
      print(_places);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(int index) {
    _places[index].isFavorite = !_places[index].isFavorite;
    notifyListeners();
  }
}
