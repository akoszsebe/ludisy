import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class SettingsController extends ControllerMVC {
  factory SettingsController(appDatabase) =>
      _this ??= SettingsController._(appDatabase);
  static SettingsController _this;
  SettingsController._(this._appDatabase);
  final AppDatabase _appDatabase;

  UserModel userData = UserModel();
  int stepCountValue = 0;

  Future<void> init() async {
    userData = await SharedPrefs.getUserData();
    stepCountValue = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
    refresh();
  }
}
