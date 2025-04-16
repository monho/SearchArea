import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Termsviewmodel extends ChangeNotifier {
  bool _allAgreed = false;
  bool _gpsTerms = false;
  String? _errorMessage;

  bool get allAgreed => _allAgreed;
  bool get gpsTerms => _gpsTerms;
  String? get errorMessage => _errorMessage;

  //전체 동의 체크박스 상태변경
  void toggleAllAgreed(bool? value) {
    _allAgreed = value ?? false;
    _gpsTerms = _allAgreed;
    _errorMessage = null;
    notifyListeners();
  }

  // 위치 서비스 약관 체크박스 변경
  void toggleGpsTerms(bool? value) {
    _gpsTerms = value ?? false;
    _allAgreed = _gpsTerms;
    _errorMessage = null;
    notifyListeners();
  }

  // 위치 권한 요청
  Future<void> requestLocationPermission(BuildContext context) async {
    if (!_gpsTerms) {
      _errorMessage = '위치 기반 서비스 약관에 동의해야 합니다.';
      notifyListeners();
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      _errorMessage = null;
      // 권한이 허용된 경우 다음 화면으로 이동하거나 로직 추가
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('위치 권한이 허용되었습니다.')));
    } else if (status.isDenied) {
      _errorMessage = '위치 권한이 거부되었습니다. 설정에서 권한을 허용해주세요.';
    } else if (status.isPermanentlyDenied) {
      _errorMessage = '위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.';
      await openAppSettings(); // 설정 화면으로 이동
    }
    notifyListeners();
  }
}
