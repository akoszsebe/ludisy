import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/states/user_state.dart';

class StartController extends ControllerMVC {
  factory StartController(appDatabase) =>
      _this ??= StartController._(appDatabase);
  static StartController _this;
  StartController._(this._appDatabase);
  final AppDatabase _appDatabase;

  int stepCountValue = 0;
  UserModel get userData => UserState.getUserData();

  Difficulty difficulty = Difficulty.easy;

  Future<void> init() async {
    stepCountValue = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
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

enum Difficulty { easy, normal, hard, veryhard, impoible }
