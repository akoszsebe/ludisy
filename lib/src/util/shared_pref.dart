import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';

class SharedPrefs {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _userData = "userdata";


  static Future<UserModel> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userdataJson = prefs.getString(_userData);
    if (userdataJson != null) {
      return UserModel.fromJson(json.decode(userdataJson));
    }
    return null;
  }

  static Future<bool> setUserData(UserModel value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userData, json.encode(value.toJson()));
  }

}