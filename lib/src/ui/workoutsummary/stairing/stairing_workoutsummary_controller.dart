import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

class StairingWorkoutSummaryController extends ControllerMVC {
  int index = 0;
  StairingObj selected = StairingObj(count: 0, whenSec: 0);

  void changePosition(WorkOut workout, int _index) {
    selected = (workout.data as Stairing).snapShots[index];
    index = _index;
  }
}
