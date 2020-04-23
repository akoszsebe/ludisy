import 'package:floor/floor.dart';

@entity
class WorkOut {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int steps;
  final double cal;
  final int duration;
  final int timeStamp;
  final String userId;

  WorkOut(this.id, this.steps, this.cal, this.duration, this.timeStamp,this.userId);
}
