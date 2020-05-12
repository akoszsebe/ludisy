import 'dart:async';
import 'package:flutter/material.dart';
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

  Future<void> init() async {
    _startime = DateTime.now().millisecondsSinceEpoch;
    _offset = await _pedometer.pedometerStream.first;
    print("start from = $_offset");
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
    StairingForegroundService.startFGS();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
    workoutState = WorkoutState.running;
    refresh();
    //  mock();
  }

  void stopListening() async {
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

  Future<void> mock() async {
    print("target = $targetSteps");
    for (var i = 0; i < targetSteps + 10; i += 10) {
      calCounterValue = CaloriCalculator.calculeteCalories(
          userState.getUserData(), durationSeconds, stepCountValue);
      stepCountValue = i;
      percentageValue = stepCountValue / targetSteps;
      checkPercentage();
      refresh();
      if (workoutState != WorkoutState.running) {
        break;
      }
      await Future.delayed(Duration(milliseconds: 2000));
    }
  }

  void checkPercentage() {
    if (percentageValue > 1) {
      percentageValue = 1;
    }
    // if (percentageValue == 1) {
    //   FlutterRingtonePlayer.playNotification();
    //   workoutState = WorkoutState.finised;
    //   refresh();
    // }
  }

  void _onData(int stepCountValue) async {
    print("OnData pedometer tracking ${stepCountValue - _offset}");
    var cal = CaloriCalculator.calculeteCalories(
        userState.getUserData(), durationSeconds, stepCountValue);
    if (cal > 0) {
      calCounterValue = cal;
    }
    this.stepCountValue = stepCountValue - _offset;
    percentageValue = this.stepCountValue / targetSteps;
    checkPercentage();
    refresh();
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

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
    savedWorkout = WorkOut(
        id: null,
        duration: durationSeconds,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        cal: calCounterValue,
        type: 0,
        data: Stairs(stairsCount: stepCountValue, snapShots: snapShots));
    await _workOutDao.insertWorkOut(savedWorkout);
    userState.addWorkout(savedWorkout);
  }

  void paused() {
    _timer.cancel();
  }

  Future<void> resume() async {
    if (workoutState == WorkoutState.running) {
      startTimer();
      var data = await _pedometer.pedometerStream.first;
      _onData(data);
    }
  }

  Future<List<StairingObj>> stopWorkout() async {
    stopListening();
    workoutState = WorkoutState.finised;
    var result = await StairingForegroundService.stopFGS();
    result.forEach((e) {
      e.count -= _offset;
      e.whenSec = (e.whenSec - _startime) ~/ 1000;
    });
    print("result -------------- $result");
    return result;
  }
}
