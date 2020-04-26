import 'package:flutter/material.dart';
import 'package:ludisy/src/util/style/colors.dart';

class AppTheme {
  static get appTheme {
    final primaryIconTheme = ThemeData.light().primaryIconTheme;
    final primaryTextTheme = ThemeData.light().primaryTextTheme;
    final accentIconTheme = ThemeData.dark().accentIconTheme;
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.blue,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.grey[300],
      accentColor: AppColors.blue,
      backgroundColor: Colors.white,
      textSelectionColor: Colors.cyan[200],
      canvasColor: Colors.grey[100],
      cardColor: Colors.white.withOpacity(0.15),
      toggleableActiveColor: Colors.cyan[300],
      accentIconTheme: accentIconTheme.copyWith(color: Colors.grey[900]),
      primaryTextTheme: primaryTextTheme.apply(bodyColor: Colors.grey[900]),
      scaffoldBackgroundColor: Colors.white,
      primaryIconTheme: primaryIconTheme.copyWith(color: Colors.grey[900]),
    );
  }
}

