import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/di/locator.dart';
import 'package:stairstepsport/src/mvcapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stetho.initialize();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final workOutDao = database.workoutDao;
  workOutDao.setLocalAppDatabase(database);
  setupLocator(workOutDao);
  runApp(EasyLocalization(child: MVCApp()));
}
