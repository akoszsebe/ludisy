import 'package:flutter/material.dart';
import 'package:ludisy/src/util/style/colors.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme = false;

  ThemeProvider();

  void setLight() {
    AppColors.createLight();
    notifyListeners();
  }

  void setDark() {
    AppColors.createDark();
    notifyListeners();
  }
}
