import 'package:objectdb/objectdb.dart';

abstract class AppDatabase {
  Future<void> insert(Map<dynamic, dynamic> doc);

  Future<void> update(
      Map<dynamic, dynamic> query, Map<dynamic, dynamic> changes);

  Future<void> delete(Map query);

  Future<Map<dynamic, dynamic>> findFirst(Map<dynamic, dynamic> query);

  Future<void> tidyUp();
}

class AppDatabaseImpl implements AppDatabase {
  ObjectDB _db;

  AppDatabaseImpl._internal(this._db);

  factory AppDatabaseImpl(String databasePath) {
    return AppDatabaseImpl._internal(ObjectDB(databasePath));
  }

  @override
  Future<void> insert(Map<dynamic, dynamic> doc) async {
    _db.open();
    _db.insert(doc);
    await _db.close();
  }

  @override
  Future<Map<dynamic, dynamic>> findFirst(Map<dynamic, dynamic> query) async {
    _db.open();
    var result = await _db.first(query);
    await _db.close();
    return result;
  }

  @override
  Future<void> update(
      Map<dynamic, dynamic> query, Map<dynamic, dynamic> changes) async {
    _db.open();
    _db.update(query, changes);
    await _db.close();
  }

  @override
  Future<void> delete(Map query) async {
    _db.open();
    _db.remove(query);
    await _db.close();
  }

  @override
  Future<void> tidyUp() async {
    _db.open();
    _db.tidy();
    await _db.close();
  }
}
