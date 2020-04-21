import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/states/user_state.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class LoginController extends ControllerMVC {
  factory LoginController() => _this ??= LoginController._();
  static LoginController _this;
  LoginController._();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  UserModel userData = UserState.getUserData();
  bool field1 = true;
  bool field2 = true;
  bool field3 = true;
  bool field4 = true;

  void login(Function(String) callback) async {
    try {
      await _googleSignIn.signIn();
      userData = UserModel(
          displayName: _googleSignIn.currentUser.displayName,
          photoUrl: _googleSignIn.currentUser.photoUrl,
          userId: _googleSignIn.currentUser.email);
      await UserState.setUserData(userData);
      callback(null);
    } catch (err) {
      print(err);
      callback(err.message);
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

  void bithDateChange(String v) {
    userData.bithDate = int.parse(v);
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

    await SharedPrefs.setUserData(userData);
    callback();
  }
}
