import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/persitance/dao/workout_dao.dart';
import 'package:stairstepsport/src/di/locator.dart';
import 'package:stairstepsport/src/states/user_state.dart';

class StartController extends ControllerMVC {
  final WorkOutDao _workoutDao = locator<WorkOutDao>();
  final UserState userState = locator<UserState>();

  int stepCountValue = 0;

  Difficulty difficulty = Difficulty.easy;

  Future<void> init() async {
    stepCountValue = await _workoutDao.getAllSteps();
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
