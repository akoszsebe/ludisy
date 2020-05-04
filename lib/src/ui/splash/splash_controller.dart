import 'package:ludisy/src/data/auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class SplashController extends ControllerMVC {
  final Auth auth = locator<Auth>();
  final UserState _userState = locator<UserState>();

  void checkLogin(Function(bool) callback) async {
    var logedInUser = await auth.isSignedIn();
    if (logedInUser != null) {
      await _userState.initState(logedInUser.uid);
      if (_userState.getUserData() != null) {
        callback(true);
        return;
      }
    }
    callback(false);
  }
}
