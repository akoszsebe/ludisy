import 'package:firebase_database/firebase_database.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/base_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

abstract class WorkOutDao {
  Future<void> insertWorkOut(WorkOut workout);

  Future<List<WorkOut>> findAllWorkOuts();

  Future<List<WorkOut>> findWorkOutBetween(int date1, int date2);
}

class WorkOutDaoImpl extends BaseDao implements WorkOutDao {
  final UserState userState = locator<UserState>();

  @override
  Future<void> insertWorkOut(WorkOut workout) async {
    userRef
        .child(userState.getUserData().userId)
        .child("workOuts")
        .push()
        .update(workout.toJson());
  }

  @override
  Future<List<WorkOut>> findAllWorkOuts() async {
    DataSnapshot snapshot = await userRef
        .child(userState.getUserData().userId)
        .child("workOuts")
        .once();
    return WorkOut.listFrom(snapshot);
  }

  @override
  Future<List<WorkOut>> findWorkOutBetween(int date1, int date2) async {
    DataSnapshot snapshot = await userRef
        .child(userState.getUserData().userId)
        .child("workOuts")
        .orderByChild("timeStamp")
        .startAt(date1, key: "timeStamp")
        .endAt(date2, key: "timeStamp")
        .once();
    return WorkOut.listFrom(snapshot);
  }
}
