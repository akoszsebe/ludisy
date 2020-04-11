import 'package:floor/floor.dart';
import 'package:stairstepsport/src/data/model/workout_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';

 @dao
 abstract class WorkOutDao {
   @Query('SELECT * FROM WorkOut')
   Future<List<WorkOut>> findAllWorkOuts();

   @Query('SELECT * FROM WorkOut WHERE timeStamp BETWEEN :date1 AND :date2')
   Future<List<WorkOut>> findWorkOutBetween(int date1,int date2);

   //@Query('SELECT sum(steps) FROM WorkOut')
   Future<int> getAllSteps(AppDatabase database) async {
    final Map<String, dynamic> numbersSum = (await database.database.rawQuery('SELECT SUM(steps) FROM WorkOut')).first;
    return numbersSum["SUM(steps)"];
   }

   @insert
   Future<void> insertWorkOut(WorkOut person);
 }