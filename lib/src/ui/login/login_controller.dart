import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class LoginController extends ControllerMVC {
  factory LoginController() => _this ??= LoginController._();
  static LoginController _this;
  LoginController._();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool logedIn;

  UserModel userData = UserModel();

  void checkLogin(Function(bool) callback) async {
    logedIn = await _googleSignIn.isSignedIn();
    callback(logedIn);
    refresh();
  }

  void login(Function(String) callback) async {
    try {
      await _googleSignIn.signIn();
      userData = UserModel(
          displayName: _googleSignIn.currentUser.displayName,
          photoUrl: _googleSignIn.currentUser.photoUrl,
          userId: _googleSignIn.currentUser.email);
      await SharedPrefs.setUserData(userData);
      callback(null);
    } catch (err) {
      print(err);
      callback(err.message);
    }
  }

  void logout() {
    _googleSignIn.signOut();
    SharedPrefs.setUserData(null);
  }

  void genderChange(String v) {
    userData.gender = v;
    refresh();
  }

  void weightChange(String v) {
    userData.weight = v;
    refresh();
  }

  void bithDateChange(String v) {
    userData.bithDate = v;
    refresh();
  }

  void heightChange(String v) {
    userData.height = v;
    refresh();
  }

  Future<void> saveUserdata(VoidCallback callback) async {
    if (userData.gender == null){
      return;
    }
    if (userData.bithDate == null){
      return;
    }
    if (userData.height == null){
      return;
    }
    if (userData.weight == null){
      return;
    }
    await SharedPrefs.setUserData(userData);
    callback();
  }
}
