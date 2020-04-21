import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class UserState {
  static UserModel _userModel = UserModel();

  static initState() async {
    _userModel = await SharedPrefs.getUserData();
  }

  static UserModel getUserData() {
    return _userModel;
  }

  static Future<void> setUserData(UserModel data) async {
    await SharedPrefs.setUserData(data);
    _userModel = data;
  }
}
