import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/mvcapp.dart';
import 'package:stairstepsport/src/util/navigation_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stetho.initialize();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  NavigationModule.setAppDatabase(database);
  runApp(EasyLocalization(child: MVCApp()));
}
