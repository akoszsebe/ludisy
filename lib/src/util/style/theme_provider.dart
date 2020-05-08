import 'package:flutter/material.dart';
import 'package:ludisy/src/util/shared_prefs.dart';
import 'package:ludisy/src/util/style/colors.dart';

class ThemeProvider with ChangeNotifier {
  String _themeName = "LIGHT";

  ThemeProvider(String theme) {
    switch (theme) {
      case "LIGHT":
        _themeName = "LIGHT";
        AppColors.createLight();
        break;
      case "DARK":
        _themeName = "DARK";
        AppColors.createDark();
        break;
      default:
        _themeName = "LIGHT";
        AppColors.createLight();
    }
  }

  String get themeName => _themeName;

  Future<void>  setLight() async {
    _themeName = "LIGHT";
    AppColors.createLight();
    await SharedPrefs.setTheme(_themeName);
    notifyListeners();
  }

  Future<void> setDark() async {
    _themeName = "DARK";
    AppColors.createDark();
    await  SharedPrefs.setTheme(_themeName);
    notifyListeners();
  }
}
