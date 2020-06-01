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

  int selelectedWorkoutIndex = 0;
  List<DayModel> datasetStairing = List();
  List<DayModel> datasetBiking = List();
  List<DayModel> datasetRollerSkating = List();
  DateTime lastDay = DateTime.now();
  DateTime firstDay = DateTime.now();
  DayModel selectedDayStairing = DayModel();
  DayModel selectedDayBiking = DayModel();
  DayModel selectedDayRollerSkating = DayModel();
  List<ChartItem> itemsStairings = List();
  List<ChartItem> itemsBikings = List();
  List<ChartItem> itemsRollerSkatings = List();

  Future<void> init() async {
    var today = DateTime.now();
    fillForWeek(today);
  }

  Future<void> fillForWeek(DateTime lastDayFromThatWeek) async {
    datasetStairing = List();
    itemsStairings = List();
    itemsBikings = List();
    itemsRollerSkatings = List();
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
    selectedDayStairing = datasetStairing[datasetStairing.length - 1];
    selectedDayBiking = datasetBiking[datasetBiking.length - 1];
    selectedDayRollerSkating = datasetRollerSkating[datasetRollerSkating.length - 1];
    refresh();
  }

  Future<void> addDay(DateTime dateTime, List<WorkOut> workoutsForaWeek) async {
    var morning = DateTime(dateTime.year, dateTime.month, dateTime.day);
    var night =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59)
            .millisecondsSinceEpoch;
    workoutsForaWeek.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
    var workoutsForCurrentDay = workoutsForaWeek.where((x) =>
        x.timeStamp >= morning.millisecondsSinceEpoch && x.timeStamp <= night);
    fillForStairing(
        workoutsForCurrentDay.where((element) => element.type == 0).toList(),
        morning);
    fillForBiking(
        workoutsForCurrentDay.where((element) => element.type == 1).toList(),
        morning);
    fillForRollerSkating(
        workoutsForCurrentDay.where((element) => element.type == 2).toList(),
        morning);
  }

  void changeSelected(int index) {
    selectedDayStairing = datasetStairing[index];
    selectedDayBiking = datasetBiking[index];
    selectedDayRollerSkating = datasetRollerSkating[index];
    refresh();
  }

  void fillForStairing(List<WorkOut> workoutsForCurrentDay, DateTime morning) {
    var d = DayModel();
    d.date = morning.day;
    for (var l in workoutsForCurrentDay) {
      d.totalSteps += (l.data as Stairs).stairsCount;
      d.workouts.add(l);
    }
    datasetStairing.add(d);
    itemsStairings.add(ChartItem(d.totalSteps, d.date.toString()));
  }

  void fillForBiking(List<WorkOut> workoutsForCurrentDay, DateTime morning) {
    var d = DayModel();
    d.date = morning.day;
    for (var l in workoutsForCurrentDay) {
      d.totalDistance += (l.data as Biking).distance;
      d.workouts.add(l);
    }
    datasetBiking.add(d);
    itemsBikings.add(ChartItem(d.totalDistance.toInt(), d.date.toString()));
  }

  void fillForRollerSkating(
      List<WorkOut> workoutsForCurrentDay, DateTime morning) {
    var d = DayModel();
    d.date = morning.day;
    for (var l in workoutsForCurrentDay) {
      d.totalDistance += (l.data as RollerSkating).distance;
      d.workouts.add(l);
    }
    datasetRollerSkating.add(d);
    itemsRollerSkatings
        .add(ChartItem(d.totalDistance.toInt(), d.date.toString()));
  }

  void setSelelectedWorkoutIndex(int index) {
    selelectedWorkoutIndex = index;
    refresh();
  }
}
