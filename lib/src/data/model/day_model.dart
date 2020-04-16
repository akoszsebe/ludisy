import 'package:stairstepsport/src/data/model/workout_model.dart';

class DayModel {
  int date = 0;
  int totalSteps = 0;
  int totalTimes = 0;
  double totalCals = 0;
  List<WorkOut> workouts = List();

  DayModel();
}