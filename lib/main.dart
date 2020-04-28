import 'dart:io';

import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/mvcapp.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stetho.initialize();
  InAppPurchaseConnection.enablePendingPurchases();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  setupLocator("${appDocDir.path}/ludisyapp.db");
  runApp(EasyLocalization(child: MVCApp()));
}
