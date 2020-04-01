import 'package:flutter/material.dart';

class AppTheme {
  static get appTheme {
    final primaryIconTheme = ThemeData.light().primaryIconTheme;
    final primaryTextTheme = ThemeData.light().primaryTextTheme;
    final accentIconTheme = ThemeData.dark().accentIconTheme;
    return ThemeData.dark().copyWith(
      primaryColor: Colors.red[800],
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.grey[800],
      accentColor: Colors.cyan[300],
      backgroundColor: Colors.white,
      textSelectionColor: Colors.cyan[200],
      cardColor: Colors.white.withOpacity(0.15),
      toggleableActiveColor: Colors.cyan[300],
      accentIconTheme: accentIconTheme.copyWith(color: Colors.grey[900]),
      primaryTextTheme: primaryTextTheme.apply(bodyColor: Colors.grey[900]),
      scaffoldBackgroundColor: Colors.white,
      primaryIconTheme: primaryIconTheme.copyWith(color: Colors.grey[900]),
    );
  }
}

