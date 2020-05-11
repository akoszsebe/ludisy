import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final String _userData = "userdata";
  static final String _theme = "theme";
  static final String _currentWorkout = "currentWorkout";

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(_userData);
    return userId;
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userData, value);
  }

  static Future<String> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_theme) ?? "";
  }

  static Future<bool> setTheme(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_theme, value);
  }

  static Future<String> getCurrentWorkout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentWorkout) ?? "";
  }

  static Future<bool> setCurrentWorkout(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_currentWorkout, value);
  }
}
