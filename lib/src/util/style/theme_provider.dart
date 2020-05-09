import 'package:flutter/material.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/util/shared_prefs.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/util/style/map_style.dart';

class ThemeProvider with ChangeNotifier {
  String _themeName = "LIGHT";
  AppMapStyle _appMapStyle = locator<AppMapStyle>();

  ThemeProvider(String theme) {
    switch (theme) {
      case "LIGHT":
        _themeName = "LIGHT";
        AppColors.createLight();
        _appMapStyle.loadMapLightStyle();
        break;
      case "DARK":
        _themeName = "DARK";
        AppColors.createDark();
        _appMapStyle.loadMapDarkStyle();
        break;
      default:
        _themeName = "LIGHT";
        AppColors.createLight();
        _appMapStyle.loadMapLightStyle();
    }
  }

  String get themeName => _themeName;

  Future<void>  setLight() async {
    _themeName = "LIGHT";
    AppColors.createLight();
    await SharedPrefs.setTheme(_themeName);
    await _appMapStyle.loadMapLightStyle();
    notifyListeners();
  }

  Future<void> setDark() async {
    _themeName = "DARK";
    AppColors.createDark();
    await  SharedPrefs.setTheme(_themeName);
    await  _appMapStyle.loadMapDarkStyle();
    notifyListeners();
  }
}
