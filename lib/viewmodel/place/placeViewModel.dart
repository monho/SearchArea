import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:searcharea/core/api_service.dart';
import 'package:searcharea/model/place/place_model.dart';

class PlaceViewModel with ChangeNotifier {
  final NaverApiService _naverApiService = NaverApiService();
  List<Place> _places = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Position? _currentPosition;

  List<Place> get places => _places;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  PlaceViewModel() {
    _determinePosition();
  }

  // 위치 권한 요청 및 현재 위치 가져오기
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스 활성화 여부 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _errorMessage = '위치 서비스가 비활성화되어 있습니다.';
      notifyListeners();
      return;
    }

    // 위치 권한 확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _errorMessage = '위치 권한이 거부되었습니다.';
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _errorMessage = '위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.';
      notifyListeners();
      return;
    }

    // 현재 위치 가져오기
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      notifyListeners();
    } catch (e) {
      _errorMessage = '위치 정보를 가져오는 데 실패했습니다: $e';
      notifyListeners();
    }
  }

  Future<void> fetchPlaces(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _places = await _naverApiService.fetchPlaces(query);
      if (_currentPosition != null) {
        // 각 장소의 거리 계산 (더미 위도/경도 사용)
        for (var place in _places) {
          // 실제로는 KATECH 좌표를 WGS84로 변환해야 함
          // 여기서는 mapx, mapy를 더미 위도/경도로 가정
          double placeLat = place.mapy / 10000.0; // 더미 위도
          double placeLon = place.mapx / 10000.0; // 더미 경도

          place.distance =
              Geolocator.distanceBetween(
                _currentPosition!.latitude,
                _currentPosition!.longitude,
                placeLat,
                placeLon,
              ) /
              1000; // km 단위로 변환
        }

        // 거리순으로 정렬
        _places.sort((a, b) => a.distance.compareTo(b.distance));
      }
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
