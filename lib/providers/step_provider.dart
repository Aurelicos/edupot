import 'package:flutter/material.dart';

class StepProvider with ChangeNotifier {
  int _step = 1;

  int get selectedIndex => _step;

  set selectedIndex(int index) {
    _step = index;
    notifyListeners();
  }
}
