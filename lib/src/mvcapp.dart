import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ludisy/src/ui/base/app_builder.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/ui/splash/splash_screen.dart';

class MVCApp extends AppMVC {
  final String theme;
  MVCApp(this.theme);

  Widget build(BuildContext context) {
    return AppBuilder(
        widget: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ludisy',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      routes: {"/": (context) => SplashScreen()},
    ));
  }
}
