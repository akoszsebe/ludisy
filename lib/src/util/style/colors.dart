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

  Color primary = const Color(0xffffffff);
  Color primaryDark = const Color(0xffffffff);
  Color primaryWithOcupacity50 = const Color(0xffffffff);
  Color secundary = const Color(0xffffffff);
  Color textBlack = const Color(0xffffffff);
  Color textGray = const Color(0xffffffff);
  Color grayIconAsset = const Color(0xffffffff);
  Color containerColor = const Color(0xffffffff);
}

class _AppColorsLight extends AppColors {
  _AppColorsLight();

  Color primary = const Color(0xff7FA1F6);
  Color primaryDark = const Color(0xff607abf);
  Color primaryWithOcupacity50 = const Color(0x807FA1F6);
  Color secundary = const Color(0xffEA4335);
  Color textBlack = const Color(0xff010101);
  Color textGray = const Color(0xff010101);
  Color grayIconAsset = const Color(0xff525252);
  Color containerColor = const Color(0xffffffff);
}

class _AppColorsDark extends AppColors {
  _AppColorsDark();
  Color primary = const Color(0xff7FA1F6);
  Color primaryDark = const Color(0xff2a2a2a);
  Color primaryWithOcupacity50 = const Color(0x807FA1F6);
  Color secundary = const Color(0xffEA4335);
  Color textBlack = const Color(0xff010101);
  Color textGray = const Color(0xff010101);
  Color grayIconAsset = const Color(0xff7e7e7e);
  Color containerColor = const Color(0xff525252);
}
