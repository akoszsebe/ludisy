import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class SplashController extends ControllerMVC {
  GoogleSignIn _googleSignIn = locator<GoogleSignIn>();
  UserState _userState = locator<UserState>();

  void checkLogin(Function(bool) callback) async {
    bool logedIn = await _googleSignIn.isSignedIn();
    if (logedIn) {
      await _userState.initState();
      if (_userState.getUserData() != null) {
        callback(true);
        return;
      }
    }
    callback(false);
  }
}
