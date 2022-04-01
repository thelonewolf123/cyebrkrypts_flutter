import 'package:flutter/material.dart';

class CompilerTabProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
