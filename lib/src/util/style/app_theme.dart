import 'package:flutter/material.dart';

class AppTheme {
  static get appTheme {
    final primaryIconTheme = ThemeData.light().primaryIconTheme;
    final primaryTextTheme = ThemeData.light().primaryTextTheme;
    return ThemeData.dark().copyWith(
      primaryColor: Colors.blue,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      accentColor: Colors.blue,
      backgroundColor: Colors.white,
      textSelectionColor: Colors.cyan[200],
      canvasColor: Colors.white,
      cardColor: Colors.white.withOpacity(0.15),
      toggleableActiveColor: Colors.cyan[300],
      primaryTextTheme: primaryTextTheme.apply(bodyColor: Colors.grey[900]),
      scaffoldBackgroundColor: Colors.white,
      primaryIconTheme: primaryIconTheme.copyWith(color: Colors.grey[900]),
    );
  }
}

