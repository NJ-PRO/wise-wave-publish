import 'package:flutter/material.dart';
import 'package:wisewave/components/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
ThemeData _themeData = defaultMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void togleTheme(int themeType) {
    switch (themeType) {
      case 0:
        themeData = defaultMode;
        break;
      case 1:
        themeData = darkMode;
        break;
      case 2:
        themeData = saharaMode;
        break;
      case 3:
        themeData = natureMode;
        break;
      default:
        themeData = defaultMode;
    }
  }
}