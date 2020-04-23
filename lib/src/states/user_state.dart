import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class UserState {
  UserState();
  UserModel _userModel = UserModel();

  Future<void> initState() async {
    _userModel = await SharedPrefs.getUserData();
  }

  UserModel getUserData() {
    return _userModel;
  }

  Future<void> setUserData(UserModel data) async {
    await SharedPrefs.setUserData(data);
    _userModel = data;
  }
}
