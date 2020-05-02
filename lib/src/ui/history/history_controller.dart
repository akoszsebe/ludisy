import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/day_model.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/widgets/app_bar_chart.dart';

class HistoryController extends ControllerMVC {
  HistoryController();

  final WorkOutDao _workoutDao = locator<WorkOutDao>();
  final UserState userState = locator<UserState>();

  List<DayModel> dataset = List();
  DateTime lastDay = DateTime.now();
  DateTime firstDay = DateTime.now();
  DayModel selectedDay = DayModel();
  List<ChartItem> itemsSteps = List();
  List<ChartItem> itemsTimes = List();
  List<ChartItem> itemsCals = List();

  Future<void> init() async {
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
    var workoutsForaWeek = await _workoutDao.findWorkOutBetween(
        DateTime(firstDay.year, firstDay.month, firstDay.day)
            .millisecondsSinceEpoch,
        DateTime(lastDay.year, lastDay.month, lastDay.day, 23, 59, 59)
            .millisecondsSinceEpoch);
    await addDay(
        lastDayFromThatWeek.subtract(Duration(days: 6)), workoutsForaWeek);
    await addDay(
        lastDayFromThatWeek.subtract(Duration(days: 5)), workoutsForaWeek);
    await addDay(
        lastDayFromThatWeek.subtract(Duration(days: 4)), workoutsForaWeek);
    await addDay(
        lastDayFromThatWeek.subtract(Duration(days: 3)), workoutsForaWeek);
    await addDay(
        lastDayFromThatWeek.subtract(Duration(days: 2)), workoutsForaWeek);
    await addDay(
        lastDayFromThatWeek.subtract(Duration(days: 1)), workoutsForaWeek);
    await addDay(lastDayFromThatWeek, workoutsForaWeek);
    selectedDay = dataset[dataset.length - 1];
    refresh();
  }

  Future<void> addDay(DateTime dateTime, List<WorkOut> workoutsForaWeek) async {
    var morrning = DateTime(dateTime.year, dateTime.month, dateTime.day);
    var night =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59)
            .millisecondsSinceEpoch;
    var workoutsForCurrentDay = workoutsForaWeek.where((x) =>
        x.timeStamp >= morrning.millisecondsSinceEpoch && x.timeStamp <= night);
    var d = DayModel();
    d.date = morrning.day;
    for (var l in workoutsForCurrentDay) {
      d.totalSteps += (l.data as Stairs).stairsCount;
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
