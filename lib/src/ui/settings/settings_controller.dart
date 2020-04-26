import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends ControllerMVC {
  final UserState userState = locator<UserState>();

  UserModel userData = UserModel();

  Future<void> init() async {
    userData = userState.getUserData();
    refresh();
  }

  void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
