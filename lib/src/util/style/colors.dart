import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors();

  AppColors.createLight() {
    _this = _AppColorsLight();
  }

  AppColors.createDark() {
    _this = _AppColorsDark();
  }

  static AppColors _this;

  static AppColors get instance => _this;

  Color blue = const Color(0xffffffff);
  Color blueDark = const Color(0xffffffff);
  Color blueWithOcupacity50 = const Color(0xffffffff);
  Color red = const Color(0xffffffff);
  Color textBlack = const Color(0xffffffff);
  Color textGray = const Color(0xffffffff);
  Color grayIconAsset = const Color(0xffffffff);
  Color containerColor = const Color(0xffffffff);
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
  Color containerColor = const Color(0xffffffff);
}

class _AppColorsDark extends AppColors {
  _AppColorsDark();
  Color blue = const Color(0xff7FA1F6);
  Color blueDark = const Color(0xff887abf);
  Color blueWithOcupacity50 = const Color(0x807FA1F6);
  Color red = const Color(0xffEA4335);
  Color textBlack = const Color(0xff010101);
  Color textGray = const Color(0xff010101);
  Color grayIconAsset = const Color(0xff525252);
  Color containerColor = const Color(0xff525252);
}
