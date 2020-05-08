import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:pedometer/pedometer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/util/calory_calculator.dart';
import 'package:ludisy/src/util/navigation_module.dart';

class StairingWorkoutController extends ControllerMVC {
  final UserState userState = locator<UserState>();
  final WorkOutDao _workOutDao = locator<WorkOutDao>();
  final Pedometer _pedometer = locator<Pedometer>();

  int stepCountValue = 0;
  double calCounterValue = 0;
  bool isWorkoutStarted = false;
  int targetSteps = 0;
  double percentageValue = 0;
  int durationSeconds = 0;

  StreamSubscription<int> _subscription;
  int _offset = 0;
  Timer _timer;
  int _startime = 0;

  Future<void> init() async {
    _offset = await _pedometer.pedometerStream.first;
    print("start from = $_offset");
    startListening();
  }

  Future<void> startListening() async {
    _startime = DateTime.now().millisecondsSinceEpoch;
    startTimer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
    isWorkoutStarted = true;
    refresh();
    // mock();
  }

  void startTimer() {
    durationSeconds =
        (DateTime.now().millisecondsSinceEpoch - _startime) ~/ 1000;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      durationSeconds++;
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
      if (!isWorkoutStarted) {
        break;
      }
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  void checkPercentage() {
    if (percentageValue > 1) {
      percentageValue = 1;
    }
    if (percentageValue == 1) {
      FlutterRingtonePlayer.playNotification();
      doneWorkout((steps, stepsPlaned, cal, duration) {
        NavigationModule.navigateToStairingWorkoutDoneScreen(
            context, steps, stepsPlaned, cal, duration);
      });
    }
  }

  void stopListening() {
    isWorkoutStarted = false;
    if (_subscription != null) {
      _subscription.cancel();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    refresh();
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

  void setupTargetSteps(int stepPlan) {
    targetSteps = stepPlan;
    durationSeconds = 0;
    percentageValue = 0;
    stepCountValue = 0;
    calCounterValue = 0;
  }

  void replanWorkOut(VoidCallback callback) {
    stopListening();
    durationSeconds = 0;
    stepCountValue = 0;
    calCounterValue = 0;
    callback();
  }

  Future<void> doneWorkout(Function(int, int, double, int) callback) async {
    isWorkoutStarted = false;
    if (_subscription != null) {
      _subscription.cancel();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    durationSeconds =
        ((DateTime.now().millisecondsSinceEpoch - _startime) ~/ 1000).toInt();
    var workout = WorkOut(
        id: null,
        duration: durationSeconds,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        cal: calCounterValue,
        type: 0,
        data: Stairs(stairsCount: stepCountValue));
    await _workOutDao.insertWorkOut(workout);
    userState.addWorkout(workout);
    callback(stepCountValue, targetSteps, calCounterValue, durationSeconds);
  }

  void paused() {
    _timer.cancel();
  }

  Future<void> resume() async {
    if (isWorkoutStarted) {
      startTimer();
      var data = await _pedometer.pedometerStream.first;
      _onData(data);
    }
  }
}
