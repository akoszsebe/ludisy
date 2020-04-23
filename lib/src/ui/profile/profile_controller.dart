import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/di/locator.dart';
import 'package:stairstepsport/src/states/user_state.dart';

class ProfileController extends ControllerMVC {
  final GoogleSignIn _googleSignIn = locator<GoogleSignIn>();
  final UserState userState = locator<UserState>();

  UserModel userData = UserModel();

  Future<void> init() async {
    userData = userState.getUserData();
    refresh();
  }

  Future<void> logout(VoidCallback callback) async {
    _googleSignIn.signOut();
    userData = UserModel();
    await userState.setUserData(userData);
    callback();
  }

  void genderChange(String v) {
    userData.gender = v;
    refresh();
  }

  void weightChange(String v) {
    userData.weight = int.parse(v.split(' ')[0]);
    refresh();
  }

  void bithDateChange(String v) {
    userData.bithDate = int.parse(v);
    refresh();
  }

  void heightChange(String v) {
    userData.height = int.parse(v.split(' ')[0]);
    refresh();
  }

  Future<void> saveUserdata(VoidCallback callback) async {
    if (userData.gender == null) {
      return;
    }
    if (userData.bithDate == null) {
      return;
    }
    if (userData.height == null) {
      return;
    }
    if (userData.weight == null) {
      return;
    }
    await userState.setUserData(userData);
    callback();
  }
}
