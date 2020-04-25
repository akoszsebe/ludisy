import 'package:floor/floor.dart';
import 'package:stairstepsport/src/data/model/workout_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';

@dao
abstract class WorkOutDao {
  AppDatabase _localAppDatabase;

  void setLocalAppDatabase(AppDatabase appDatabase) {
    _localAppDatabase = appDatabase;
  }

  @Query('SELECT * FROM WorkOut WHERE userId = :userId')
  Future<List<WorkOut>> findAllWorkOuts(String userId);

  @Query('SELECT * FROM WorkOut WHERE userId = :userId AND timeStamp BETWEEN :date1 AND :date2')
  Future<List<WorkOut>> findWorkOutBetween(String userId, int date1, int date2);

  //@Query('SELECT sum(steps) FROM WorkOut')
  Future<int> getAllSteps(String userId) async {
    final Map<String, dynamic> numbersSum =
        (await _localAppDatabase.database.rawQuery('SELECT SUM(steps) FROM WorkOut WHERE userId = "$userId"'))
            .first;
    return numbersSum["SUM(steps)"];
  }

  @insert
  Future<void> insertWorkOut(WorkOut workout);
}
