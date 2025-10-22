import 'package:flutter/material.dart';

class TipsViewModel extends ChangeNotifier {
  double _total = 0;
  double _percentage = 0;
  double _tipAmount = 0;
  bool _customMode = false;

  double get total => _total;
  double get percentage => _percentage;
  double get tipAmount => _tipAmount;
  bool get customMode => _customMode;

  void setTotal(String value) {
    _total = double.tryParse(value) ?? 0;
    _recalculate();
  }

  void setPercentage(double value) {
    _percentage = value;
    _customMode = false;
    _recalculate();
  }

  void setCustomMode(bool value) {
    _customMode = value;
    if (value) {
      _percentage = 0;
      _tipAmount = 0;
    }
    notifyListeners();
  }

  void setCustomTipAmount(String value) {
    _tipAmount = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  void _recalculate() {
    if (_customMode) return;
    _tipAmount = (_total * _percentage) / 100;
    notifyListeners();
  }
}
