import 'package:stairstepsport/src/data/model/workout_model.dart';

class DayModel {
  int date;
  int totalSteps;
  List<WorkOut> workouts;

  DayModel(this.date,this.totalSteps,this.workouts);
}