import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/util/shared_pref.dart';

class UserState {
  UserState();

  final WorkOutDao _workoutDao = locator<WorkOutDao>();
  UserModel _userModel = UserModel();
  int _allSteps = 0;

  Future<void> initState() async {
    _userModel = await SharedPrefs.getUserData();
    if (_userModel != null) {
      _allSteps = await _workoutDao.getAllSteps(_userModel.userId);
    }
  }

  UserModel getUserData() {
    return _userModel;
  }

  Future<void> setUserData(UserModel data) async {
    await SharedPrefs.setUserData(data);
    _userModel = data;
  }

  int getAllSteps() {
    return _allSteps;
  }

  void addSteps(int steps) {
    _allSteps += steps;
  }
}
