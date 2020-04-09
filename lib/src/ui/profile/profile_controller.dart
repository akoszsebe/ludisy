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

  UserModel get userData => _ProfileModel.userData;

  Future<void> init() async {
    var userData = await SharedPrefs.getUserData();
    _ProfileModel.setUserDate(userData);
    refresh();
  }

  Future<void> logout(VoidCallback callback) async {
    _googleSignIn.signOut();
    _ProfileModel.setUserDate(UserModel());
    await SharedPrefs.setUserData(UserModel());
    callback();
  }

  void genderChange(String v) {
    userData.gender = v;
    _ProfileModel.setUserDate(userData);
    refresh();
  }

  void weightChange(String v) {
    userData.weight = int.parse(v.split(' ')[0]);
    _ProfileModel.setUserDate(userData);
    refresh();
  }

  void bithDateChange(String v) {
    userData.bithDate = int.parse(v);
    _ProfileModel.setUserDate(userData);
    refresh();
  }

  void heightChange(String v) {
    userData.height = int.parse(v.split(' ')[0]);
    _ProfileModel.setUserDate(userData);
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

class _ProfileModel {
  static UserModel _userData = UserModel();

  static UserModel get userData => _userData;

  static void setUserDate(UserModel userData) {
    _userData = userData;
  }
}
