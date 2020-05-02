import 'package:google_sign_in/google_sign_in.dart';
import 'package:ludisy/src/util/shared_prefs.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class SplashController extends ControllerMVC {
  GoogleSignIn _googleSignIn = locator<GoogleSignIn>();
  UserState _userState = locator<UserState>();

  void checkLogin(Function(bool) callback) async {
    bool logedIn = await _googleSignIn.isSignedIn();
    var userId = await SharedPrefs.getUserId();
    if (logedIn && userId != null) {
      await _userState.initState(userId);
      if (_userState.getUserData() != null) {
        callback(true);
        return;
      }
    }
    callback(false);
  }
}
