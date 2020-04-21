import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class StartController extends ControllerMVC {
  factory StartController(appDatabase) =>
      _this ??= StartController._(appDatabase);
  static StartController _this;
  StartController._(this._appDatabase);
  final AppDatabase _appDatabase;

  int get stepCountValue => _StartModel.stepCountValue;
  UserModel get userData => _StartModel.userData;

  Difficulty difficulty = Difficulty.easy;

  Future<void> init() async {
    var userData = await SharedPrefs.getUserData();
    _StartModel.setUserDate(userData);
    var steps = 0;
    steps = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
    _StartModel.incrementCounter(steps);
    refresh();
  }

  void setUp(Function(int) callback) {
    var stepPlan = 0;
    switch (difficulty) {
      case Difficulty.easy:
        stepPlan = 100;
        break;
      case Difficulty.normal:
        stepPlan = 250;
        break;
      case Difficulty.hard:
        stepPlan = 500;
        break;
      case Difficulty.veryhard:
        stepPlan = 1000;
        break;
      case Difficulty.impoible:
        stepPlan = 10000;
        break;
    }
    callback(stepPlan);
  }

  void setDificulty(int value) {
    difficulty = Difficulty.values[value];
  }
}

class _StartModel {
  static int _stepCountValue = 0;
  static UserModel _userData = UserModel();

  static int get stepCountValue => _stepCountValue;
  static UserModel get userData => _userData;

  static void setUserDate(UserModel userData) {
    _userData = userData;
  }

  static void incrementCounter(int stepCountValue) {
    _stepCountValue = stepCountValue;
  }
}

enum Difficulty { easy, normal, hard, veryhard, impoible }
