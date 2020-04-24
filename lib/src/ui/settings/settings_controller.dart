import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/dao/workout_dao.dart';
import 'package:stairstepsport/src/di/locator.dart';
import 'package:stairstepsport/src/states/user_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends ControllerMVC {
  final WorkOutDao _workoutDao = locator<WorkOutDao>();
  final UserState userState = locator<UserState>();

  UserModel userData = UserModel();
  int stepCountValue = 0;

  Future<void> init() async {
    userData = userState.getUserData();
    stepCountValue = await _workoutDao.getAllSteps();
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
