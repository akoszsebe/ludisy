import 'package:flutter/cupertino.dart';
import 'package:ludisy/src/data/auth.dart';
import 'package:ludisy/src/data/persitance/dao/user_dao.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class LoginController extends ControllerMVC {
  final Auth auth = locator<Auth>();
  final UserState userState = locator<UserState>();
  final UserDao _userDao = locator<UserDao>();

  User userData = User();
  bool field1 = true;
  bool field2 = true;
  bool field3 = true;
  bool field4 = true;

  bool userIsRegistered = false;

  void login(Function(String) callback) async {
    try {
      var user = await auth.registerUserWithGoogle();
      userData = User(
          displayName: user.displayName,
          photoUrl: user.photoUrl,
          userId: user.uid,
          workOuts: List());
      var userFromFirebase = await _userDao.getUser(user.uid);
      auth.signOutOnyFirebase();
      if (userFromFirebase != null) {
        userData.weight = userFromFirebase.weight;
        userData.height = userFromFirebase.height;
        userData.bithDate = userFromFirebase.bithDate;
        userData.gender = userFromFirebase.gender;
        userData.workOuts = userFromFirebase.workOuts;
        refresh();
      }
      callback(null);
    } catch (err) {
      print(err);
      callback(err.toString());
    }
  }

  void genderChange(String v) {
    userData.gender = v;
    field1 = true;
    refresh();
  }

  void weightChange(String v) {
    userData.weight = int.parse(v.split(' ')[0]);
    field2 = true;
    refresh();
  }

  void bithDateChange(DateTime dateTime) {
    userData.bithDate = dateTime;
    field3 = true;
    refresh();
  }

  void heightChange(String v) {
    userData.height = int.parse(v.split(' ')[0]);
    field4 = true;
    refresh();
  }

  Future<void> saveUserdata(VoidCallback callback) async {
    if (userData.gender == null) {
      field1 = false;
      refresh();
      return;
    }
    if (userData.weight == null) {
      field2 = false;
      refresh();
      return;
    }
    if (userData.bithDate == null) {
      field3 = false;
      refresh();
      return;
    }
    if (userData.height == null) {
      field4 = false;
      refresh();
      return;
    }
    await auth.finishRegistrationAndSignIn();
    await userState.setUserData(userData);
    await userState.initState(userData.userId);
    callback();
  }
}
