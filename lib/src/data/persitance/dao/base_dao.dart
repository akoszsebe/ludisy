import 'package:firebase_database/firebase_database.dart';
import 'package:ludisy/src/di/locator.dart';

abstract class BaseDao {
  final DatabaseReference userRef = locator<DatabaseReference>(instanceName: "userFirebaseDao");
}
