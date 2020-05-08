import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/util/assets.dart';

class DayModel {
  int date = 0;
  int totalSteps = 0;
  int totalTimes = 0;
  double totalCals = 0;
  List<WorkOut> workouts = List();

  DayModel();
}

class DayQuickInfoModel {
  int durationSec = 0;
  double value = 0;
  double avgValue = 0;
  final String metric;
  String imageName = AppSVGAssets.stairing;

  DayQuickInfoModel(this.metric);
}
