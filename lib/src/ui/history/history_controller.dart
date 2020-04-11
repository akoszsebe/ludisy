import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/day_model.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class HistoryController extends ControllerMVC {
  factory HistoryController(appDatabase) =>
      _this ??= HistoryController._(appDatabase);
  static HistoryController _this;
  HistoryController._(this._appDatabase);
  final AppDatabase _appDatabase;

  UserModel userData = UserModel();
  int stepCountValue = 0;
  List<DayModel> dataset = List();

  Future<void> initPlatformState() async {
    dataset = [
      DayModel(1, 234, []),
      DayModel(2, 2, []),
      DayModel(3, 12, []),
      DayModel(4, 100, []),
      DayModel(5, 50, []),
      DayModel(6, 34, []),
    ];
    userData = await SharedPrefs.getUserData();
    stepCountValue = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
    var now = DateTime.now();
    var morrning = new DateTime(now.year, now.month, now.day);
    var night = new DateTime(now.year, now.month, now.day, 24 );
    print(" m - ${morrning} --- n - $night");
    var l1 = await _appDatabase.workoutDao.findWorkOutBetween(morrning.millisecondsSinceEpoch, night.millisecondsSinceEpoch);
    var d = DayModel(0,0,List());
    d.date = morrning.day;
    for (var l in l1){
      d.totalSteps+= l.steps;
      d.workouts.add(l);
    }
    dataset.add(d);
    refresh();
  }
}
