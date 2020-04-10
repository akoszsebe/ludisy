import 'package:mvc_pattern/mvc_pattern.dart';

class WorkOutDoneController extends ControllerMVC {
  factory WorkOutDoneController() => _this ??= WorkOutDoneController._();
  static WorkOutDoneController _this;
  WorkOutDoneController._();

  int steps = 0;
  int stepsPlaned = 0;
  double cal = 0;
  Duration duration = Duration();
  double percentageValue = 0;

  void setUpValues(int steps, int stepsPlaned, double cal, Duration duration) {
    this.steps = steps;
    this.stepsPlaned = stepsPlaned;
    this.cal = cal;
    this.duration = duration;
    this.percentageValue = steps / stepsPlaned;
    if (this.percentageValue > 1) {
      this.percentageValue = 1;
    }
  }
}
