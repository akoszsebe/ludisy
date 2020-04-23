import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/di/locator.dart';
import 'package:stairstepsport/src/states/user_state.dart';

class SettingsController extends ControllerMVC {
  final AppDatabase _appDatabase = locator<AppDatabase>();

  UserModel userData = UserState.getUserData();
  int stepCountValue = 0;

  Future<void> init() async {
    stepCountValue = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
    refresh();
  }
}
