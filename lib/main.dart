import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/mvcapp.dart';
import 'package:ludisy/src/util/secrets.dart';
import 'package:ludisy/src/util/shared_prefs.dart';
import 'package:ludisy/src/util/style/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stetho.initialize();
  InAppPurchaseConnection.enablePendingPurchases();
  Secrets secrets = await Secrets.load();
  print("secrets - ${secrets.apiKey}");
  FirebaseApp firebaseApp = await FirebaseApp.configure(
    name: secrets.fireBaseAppName,
    options: FirebaseOptions(
      googleAppID: secrets.googleAppID,
      apiKey: secrets.apiKey,
      databaseURL: secrets.databaseURL,
    ),
  );
  setupLocator(firebaseApp);
  var theme = await SharedPrefs.getTheme();
  var themeProvider = ThemeProvider(theme);
  runApp(EasyLocalization(
    child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => themeProvider, child: MVCApp(theme)),
    path: 'lib/resources/langs',
    supportedLocales: [Locale('en', 'US')],
  ));
}
