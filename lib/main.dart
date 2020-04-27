import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ludisy/src/data/persitance/database.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/mvcapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stetho.initialize();
  InAppPurchaseConnection.enablePendingPurchases();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final workOutDao = database.workoutDao;
  workOutDao.setLocalAppDatabase(database);
  setupLocator(workOutDao);
  runApp(EasyLocalization(child: MVCApp()));
}
