import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/base_dao.dart';

abstract class WorkOutDao {
  Future<void> insertWorkOut(WorkOut workout);

  Future<List<WorkOut>> findAllWorkOuts();

  Future<List<WorkOut>> findWorkOutBetween(int date1, int date2);

  Future<int> getAllSteps();
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
      appDatabase.update(user.toJsonJustUserId(), user.toJsonJustWorkouts());
    }
  }

  @override
  Future<List<WorkOut>> findAllWorkOuts() async {
    var result = List<WorkOut>();
    var userIndb = await appDatabase.findFirst({});
    if (userIndb != null) {
      var user = User.fromJson(userIndb);
      if (user.workOuts != null) {
        result = user.workOuts;
      }
    }
    return result;
  }

  @override
  Future<List<WorkOut>> findWorkOutBetween(int date1, int date2) async {
    var result = List<WorkOut>();
    var userIndb = await appDatabase.findFirst({});
    if (userIndb != null) {
      var user = User.fromJson(userIndb);
      if (user.workOuts != null) {
        result = user.workOuts
            .where((l) => l.timeStamp >= date1 && l.timeStamp <= date2)
            .toList();
      }
    }
    return result;
  }

  @override
  Future<int> getAllSteps() async {
    var result = 0;
    var userIndb = await appDatabase.findFirst({});
    if (userIndb != null) {
      var user = User.fromJson(userIndb);
      if (user.workOuts != null) {
        user.workOuts.forEach((workout) {
          if (workout.type == 0) {
            result += (workout.data as Stairs).stairsCount;
          }
        });
      }
    }
    return result;
  }
}
