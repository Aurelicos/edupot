import 'package:flutter/material.dart';

class NavbarProvider with ChangeNotifier {
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
