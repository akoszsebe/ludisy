import 'package:ludisy/src/data/persitance/database.dart';
import 'package:ludisy/src/di/locator.dart';

abstract class BaseDao {
  AppDatabase appDatabase = locator<AppDatabase>();
}
