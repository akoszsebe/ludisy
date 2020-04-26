import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [WorkOut])
abstract class AppDatabase extends FloorDatabase {
  WorkOutDao get workoutDao;
}
