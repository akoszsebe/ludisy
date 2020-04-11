import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:stairstepsport/src/mvcapp.dart';

void main() {
  Stetho.initialize();
  runApp(EasyLocalization(child: MVCApp()));
}
