import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/util/shared_prefs.dart';

class UserState {
  UserState();

  final UserDao _userDao = locator<UserDao>();
  User _userModel = User();
  int _allSteps = 0;

  Future<void> initState(String userId) async {
    _userModel = await _userDao.getUser(userId);
    if (_userModel != null) {
      print("init user - ${_userModel.toJson()}");
    } else {
      print("init user - null");
    }
    if (_userModel != null) {
      _allSteps = 0; //TODO: implement
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
    await SharedPrefs.setUserId(null);
    _userModel = User();
  }
}
