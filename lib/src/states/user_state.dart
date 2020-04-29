import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/data/persitance/database.dart';
import 'package:ludisy/src/di/locator.dart';

class UserState {
  UserState();

  final WorkOutDao _workoutDao = locator<WorkOutDao>();
  final UserDao _userDao = locator<UserDao>();
  final AppDatabase _appDatabase = locator<AppDatabase>();
  User _userModel = User();
  int _allSteps = 0;

  Future<void> initState() async {
    _userModel = await _userDao.getUser();
    if (_userModel != null) {
      print("init user - ${_userModel.toJson()}");
    } else {
      print("init user - null");
    }
    if (_userModel != null && _workoutDao != null) {
      _allSteps = await _workoutDao.getAllSteps();
    }
  }

  User getUserData() {
    return _userModel;
  }

  Future<void> setUserData(User data) async {
    await _userDao.insertOrUpdateUser(data);
    _userModel = data;
  }

  int getAllSteps() {
    return _allSteps;
  }

  void addSteps(int steps) {
    _allSteps += steps;
  }

  Future<void> removeUserData(User user) async {
    await _appDatabase.tidyUp();
    _userModel = User();
  }
}
