import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final String _userData = "userdata";

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(_userData);
    return userId;
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userData, value);
  }
}
