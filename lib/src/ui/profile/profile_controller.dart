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

  void logout() {
    _googleSignIn.signOut();
    _ProfileModel.setUserDate(null);
    SharedPrefs.setUserData(null);
  }

  void genderChange(String v) {
    userData.gender = v;
    _ProfileModel.setUserDate(userData);
    refresh();
  }

  void weightChange(String v) {
     userData.weight = v;
    _ProfileModel.setUserDate(userData);
    refresh();
  }

  void bithDateChange(String v) {
     userData.bithDate = v;
    _ProfileModel.setUserDate(userData);
    refresh();
  }

    void heightChange(String v) {
     userData.height = v;
    _ProfileModel.setUserDate(userData);
    refresh();
  }
}

class _ProfileModel {
  static UserModel _userData;

  static UserModel get userData => _userData;

  static void setUserDate(UserModel userData) {
    _userData = userData;
  }
}
