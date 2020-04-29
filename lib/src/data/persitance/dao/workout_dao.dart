import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/base_dao.dart';

abstract class WorkOutDao {
  Future<void> insertWorkOut(WorkOut workout);

  Future<List<WorkOut>> findAllWorkOuts(String userId);

  Future<List<WorkOut>> findWorkOutBetween(String userId, int date1, int date2);

  Future<int> getAllSteps(String userId);
}

class WorkOutDaoImpl extends BaseDao implements WorkOutDao {
  @override
  Future<void> insertWorkOut(WorkOut workout) async {
    var result = await appDatabase.findFirst({});
    if (result != null) {
      var user = User.fromJson(result);
      if (user.workOuts == null) {
        user.workOuts = List();
      }
      user.workOuts.add(workout);
      print("${user.toJsonJustWorkouts()}");
      appDatabase.update(user.toJsonJustUserId(), user.toJsonJustWorkouts());
    }
  }

  @override
  Future<List<WorkOut>> findAllWorkOuts(String userId) {
    // TODO: implement findAllWorkOuts
    return null;
  }

  @override
  Future<List<WorkOut>> findWorkOutBetween(
      String userId, int date1, int date2) {
    // TODO: implement findWorkOutBetween
    return null;
  }

  @override
  Future<int> getAllSteps(String userId) {
    // TODO: implement getAllSteps
    return null;
  }
}
