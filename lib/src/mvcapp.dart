import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/ui/splash/splash_screen.dart';
import 'package:ludisy/src/util/style/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:ludisy/src/util/style/colors.dart';

class MVCApp extends AppMVC {
  MVCApp();

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.blueWithOcupacity50,
    ));
    var data = EasyLocalizationProvider.of(context).data;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ludisy',
      theme: AppTheme.appTheme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //app-specific localization
        EasylocaLizationDelegate(
          locale: data.locale,
          path: 'lib/resources/langs',
        ),
      ],
      supportedLocales: [Locale('en', 'US')],
      locale: data.savedLocale,
      routes: {"/": (context) => SplashScreen()},
    );
  }
}
