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

  void checkLogin(Function(bool) callback) async {
    logedIn = await _googleSignIn.isSignedIn();
    callback(logedIn);
    refresh();
  }

  void login(Function(String) callback) async {
    try {
      await _googleSignIn.signIn();
      var user = UserModel(
          displayName: _googleSignIn.currentUser.displayName,
          photoUrl: _googleSignIn.currentUser.photoUrl,
          userId: _googleSignIn.currentUser.email);
      await SharedPrefs.setUserData(user);
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
}
