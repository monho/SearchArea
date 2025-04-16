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
  void toggleAllAgreed(bool? value){
    _allAgreed = value ?? false;
    _gpsTerms = _allAgreed;
    _errorMessage = null;
    notifyListeners();
  }

}