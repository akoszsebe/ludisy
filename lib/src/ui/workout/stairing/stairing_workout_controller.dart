import 'dart:async';
import 'package:ludisy/src/data/forgroundsevices/stairing_foreground_service.dart';
import 'package:ludisy/src/ui/workout/enum_workout_state.dart';
import 'package:pedometer/pedometer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/util/calory_calculator.dart';

class StairingWorkoutController extends ControllerMVC {
  final UserState userState = locator<UserState>();
  final WorkOutDao _workOutDao = locator<WorkOutDao>();
  final Pedometer _pedometer = locator<Pedometer>();
  final StairingForegroundService _stairingForegroundService =
      locator<StairingForegroundService>();

  bool showCounterView = true;
  int stepCountValue = 0;
  double calCounterValue = 0;
  WorkoutState workoutState = WorkoutState.paused;
  int targetSteps = 0;
  double percentageValue = 0;
  int durationSeconds = 0;
  WorkOut savedWorkout;

  StreamSubscription<int> _subscription;
  int _offset = 0;
  Timer _timer;
  int _startime = 0;
  Stream<StepCount> _stepCountStream;

  Future<void> init() async {
    //_offset = await _pedometer.pedometerStream.first;
    _stepCountStream = await Pedometer.stepCountStream;
    print("start from = $_offset");
  }

  Future<void> countDownFinished() async {
    showCounterView = false;
    _startime = DateTime.now().millisecondsSinceEpoch;
    startListening();
  }

  void setupTargetSteps(int stepPlan) {
    targetSteps = stepPlan;
    durationSeconds = 0;
    percentageValue = 0;
    stepCountValue = 0;
    calCounterValue = 0;
  }

  Future<void> startListening() async {
    startTimer();
    _stairingForegroundService.startFGS();

    /// Listen to streams and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    workoutState = WorkoutState.running;
    refresh();
  }

  Future<void> stopListening() async {
    await _stairingForegroundService.stopFGS();
    if (_subscription != null) {
      _subscription.cancel();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    workoutState = WorkoutState.paused;
    refresh();
  }

  void startTimer() {
    durationSeconds =
        (DateTime.now().millisecondsSinceEpoch - _startime) ~/ 1000;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      durationSeconds++;
      print("timer  $durationSeconds");
      refresh();
    });
  }

  void checkPercentage() {
    if (percentageValue > 1) {
      percentageValue = 1;
    }
  }

  void _onData(int stepCountValue) async {
    print("OnData pedometer tracking ${stepCountValue - _offset}");
    calculateCalories();
    this.stepCountValue = stepCountValue - _offset;
    percentageValue = this.stepCountValue / targetSteps;
    checkPercentage();
    refresh();
  }

  void onStepCount(StepCount event) {
    /// Handle step count changed
    int steps = event.steps;
    _onData(steps);
  }

  void onStepCountError(error) {
    print("Flutter Pedometer Error: $error");
  }

  Future<void> doneWorkout() async {
    if (_subscription != null) {
      _subscription.cancel();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    durationSeconds =
        ((DateTime.now().millisecondsSinceEpoch - _startime) ~/ 1000).toInt();
    var snapShots = await stopWorkout();
    calculateCalories();
    savedWorkout = WorkOut(
        id: null,
        duration: durationSeconds,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        cal: calCounterValue,
        type: 0,
        data: Stairing(stairsCount: stepCountValue, snapShots: snapShots));
    await _workOutDao.insertWorkOut(savedWorkout);
    userState.addWorkout(savedWorkout);
  }

  void paused() {
    _timer.cancel();
  }

  Future<void> resume() async {
    if (workoutState == WorkoutState.running) {
      startTimer();
    }
  }

  Future<List<StairingObj>> stopWorkout() async {
    await stopListening();
    workoutState = WorkoutState.finised;
    var result = await _stairingForegroundService.getSavedData();
    result.forEach((e) {
      e.whenSec = (e.whenSec - _startime) ~/ 1000;
    });
    print("result -------------- $result");
    await _stairingForegroundService.removeSavedData();
    refresh();
    return result;
  }

  void calculateCalories() {
    var cal = CaloriCalculator.calculeteCaloriesStairing(
        userState.getUserData(), durationSeconds, stepCountValue);
    if (cal > 0) {
      calCounterValue = cal;
    }
  }
}
