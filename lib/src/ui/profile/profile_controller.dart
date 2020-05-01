import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class ProfileController extends ControllerMVC {
  final GoogleSignIn _googleSignIn = locator<GoogleSignIn>();
  final UserState userState = locator<UserState>();
  final Query _userRef = locator<Query>(instanceName: "userFirebaseDao");

  User userData = User();

  Future<void> init() async {
    userData = userState.getUserData();
    refresh();
  }

  Future<void> logout(VoidCallback callback) async {
    _googleSignIn.signOut();
    await userState.removeUserData(userData);
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

  void bithDateChange(DateTime dateTime) {
    userData.bithDate = dateTime;
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
    _userRef.reference().child(userData.userId).update(userData.toJson());
    await userState.setUserData(userData);
    callback();
  }
}
