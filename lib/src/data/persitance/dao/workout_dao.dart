import 'package:ludisy/src/data/model/workout_model.dart';

abstract class WorkOutDao {
  Future<void> insertWorkOut(WorkOut workout);

  Future<List<WorkOut>> findAllWorkOuts(String userId);

  Future<List<WorkOut>> findWorkOutBetween(String userId, int date1, int date2);

  Future<int> getAllSteps(String userId);
}
