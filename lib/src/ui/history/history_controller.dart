import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/data/model/day_model.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/states/user_state.dart';
import 'package:stairstepsport/src/widgets/app_bar_chart.dart';

class HistoryController extends ControllerMVC {
  factory HistoryController(appDatabase) =>
      _this ??= HistoryController._(appDatabase);
  static HistoryController _this;
  HistoryController._(this._appDatabase);
  final AppDatabase _appDatabase;

  UserModel userData = UserState.getUserData();
  int stepCountValue = 0;
  List<DayModel> dataset = List();
  DateTime lastDay = DateTime.now();
  DateTime firstDay = DateTime.now();
  DayModel selectedDay = DayModel();
  List<ChartItem> itemsSteps = List();
  List<ChartItem> itemsTimes = List();
  List<ChartItem> itemsCals = List();

  Future<void> init() async {
    stepCountValue = await _appDatabase.workoutDao.getAllSteps(_appDatabase);
    var today = DateTime.now();
    fillForWeek(today);
  }

  Future<void> fillForWeek(DateTime lastDayFromThatWeek) async {
    dataset = List();
    itemsSteps = List();
    itemsTimes = List();
    itemsCals = List();
    lastDay = lastDayFromThatWeek;
    firstDay = lastDayFromThatWeek.subtract(Duration(days: 6));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 5)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 5)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 4)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 3)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 2)));
    await addDay(lastDayFromThatWeek.subtract(Duration(days: 1)));
    await addDay(lastDayFromThatWeek);
    selectedDay = dataset[dataset.length - 1];
    refresh();
  }

  Future<void> addDay(DateTime dateTime) async {
    var morrning = new DateTime(dateTime.year, dateTime.month, dateTime.day);
    var night =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    var l1 = await _appDatabase.workoutDao.findWorkOutBetween(
        morrning.millisecondsSinceEpoch, night.millisecondsSinceEpoch);
    var d = DayModel();
    d.date = morrning.day;
    for (var l in l1) {
      d.totalSteps += l.steps;
      d.totalTimes += l.duration;
      d.totalCals += l.cal;
      d.workouts.add(l);
    }
    dataset.add(d);
    itemsSteps.add(ChartItem(d.totalSteps, d.date.toString()));
    itemsTimes.add(ChartItem(d.totalTimes, d.date.toString()));
    itemsCals.add(ChartItem(d.totalCals.toInt(), d.date.toString()));
  }

  void changeSelected(int index) {
    selectedDay = dataset[index];
    refresh();
  }
}
