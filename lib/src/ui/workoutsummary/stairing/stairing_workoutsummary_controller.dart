import 'package:mvc_pattern/mvc_pattern.dart';

class StairingWorkoutSummaryController extends ControllerMVC {
  int steps = 0;
  int stepsPlaned = 0;
  double cal = 0;
  int durationSeconds = 0;
  double percentageValue = 0;

  void setUpValues(
      int steps, int stepsPlaned, double cal, int durationSeconds) {
    this.steps = steps;
    this.stepsPlaned = stepsPlaned;
    this.cal = cal;
    this.durationSeconds = durationSeconds;
    this.percentageValue = steps / stepsPlaned;
    if (this.percentageValue > 1) {
      this.percentageValue = 1;
    }
  }
}
