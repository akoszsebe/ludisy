import 'package:floor/floor.dart';
import 'package:stairstepsport/src/data/model/workout_model.dart';

 @dao
 abstract class WorkOutDao {
   @Query('SELECT * FROM WorkOut')
   Future<List<WorkOut>> findAllWorkOuts();

   @Query('SELECT * FROM WorkOut WHERE id = :id')
   Stream<WorkOut> findWorkOutById(int id);

   @insert
   Future<void> insertWorkOut(WorkOut person);
 }