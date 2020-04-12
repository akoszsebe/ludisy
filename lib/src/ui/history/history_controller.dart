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
  List<DayModel> dataset = List(7);
  DateTime lastDay;
  DateTime firstDay;
  DayModel selectedDay = DayModel(0, 0, []);

  Future<void> initPlatformState() async {
    dataset = List();
    userData = await SharedPrefs.getUserData();
    stepCountValue = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
    var today = DateTime.now();
    await fillForWeek(today);
    refresh();
  }

  Future<void> fillForWeek(DateTime lastDayFromThatWeek) async {
    lastDay = lastDayFromThatWeek;
    firstDay = lastDayFromThatWeek.subtract(Duration(days: 7));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 7)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 6)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 5)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 3)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 2)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 1)));
    await addDay(lastDayFromThatWeek);
    selectedDay = dataset[dataset.length - 1];
  }

  Future<void> addDay(DateTime dateTime) async {
    var morrning = new DateTime(dateTime.year, dateTime.month, dateTime.day);
    var night =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    print(" m - $morrning --- n - $night");
    var l1 = await _appDatabase.workoutDao.findWorkOutBetween(
        morrning.millisecondsSinceEpoch, night.millisecondsSinceEpoch);
    var d = DayModel(0, 0, List());
    d.date = morrning.day;
    for (var l in l1) {
      d.totalSteps += l.steps;
      d.workouts.add(l);
    }
    dataset.add(d);
  }

  void changeSelected(int index) {
    print("selected index $index");
    selectedDay = dataset[index];
    refresh();
  }
}
