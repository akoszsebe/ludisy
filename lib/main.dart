import 'dart:io';

import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/mvcapp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stetho.initialize();
  InAppPurchaseConnection.enablePendingPurchases();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  FirebaseApp firebaseApp = await FirebaseApp.configure(
    name: 'ludisyapp',
    options: const FirebaseOptions(
      googleAppID: '1:695310395817:android:291dedce3396ad2e3c7cb8',
      apiKey: 'AIzaSyDWtgZCyDE-u2ION5GANmLyEzskpGRI_3o',
      databaseURL: 'https://ludisy-c2af6.firebaseio.com/',
    ),
  );
  setupLocator("${appDocDir.path}/ludisyapp.db", firebaseApp);
  runApp(EasyLocalization(child: MVCApp()));
}
