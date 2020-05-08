import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors();

  AppColors.create() {
    if (_this == null) _this = _AppColorsLight();
  }

  static AppColors _this;

  static AppColors get instance => _this;

  static const Color blue = const Color(0xff7FA1F6);
  static const Color blueDark = const Color(0xff607abf);
  static const Color blueWithOcupacity50 = const Color(0x807FA1F6);
  static const Color red = const Color(0xffEA4335);
  static const Color textBlack = const Color(0xff010101);
  static const Color textGray = const Color(0xff010101);
  static const Color grayIconAsset = const Color(0xff525252);
  static const Color containerColor = Color(0xffffffff);
  // static const Color containerColor = Color(0xff525252);
}

class _AppColorsLight extends AppColors {
  _AppColorsLight();

  Color blue = const Color(0xff7FA1F6);
  Color blueDark = const Color(0xff607abf);
  Color blueWithOcupacity50 = const Color(0x807FA1F6);
  Color red = const Color(0xffEA4335);
  Color textBlack = const Color(0xff010101);
  Color textGray = const Color(0xff010101);
  Color grayIconAsset = const Color(0xff525252);
  Color containerColor = Color(0xffffffff);
}

class AppColorsDark extends AppColors {
  Color blue = const Color(0xff7FA1F6);
  Color blueDark = const Color(0xff607abf);
  Color blueWithOcupacity50 = const Color(0x807FA1F6);
  Color red = const Color(0xffEA4335);
  Color textBlack = const Color(0xff010101);
  Color textGray = const Color(0xff010101);
  Color grayIconAsset = const Color(0xff525252);
  Color containerColor = Color(0xff525252);
}
