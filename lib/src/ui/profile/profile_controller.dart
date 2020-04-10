import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class ProfileController extends ControllerMVC {
  factory ProfileController() => _this ??= ProfileController._();
  static ProfileController _this;
  ProfileController._();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  UserModel userData = UserModel();

  Future<void> init() async {
    userData = await SharedPrefs.getUserData();
    refresh();
  }

  Future<void> logout(VoidCallback callback) async {
    _googleSignIn.signOut();
    userData = UserModel();
    await SharedPrefs.setUserData(userData);
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
    await SharedPrefs.setUserData(userData);
    callback();
  }
}
