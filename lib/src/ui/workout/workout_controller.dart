import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/ui/start/start_screen.dart';
import 'package:stairstepsport/src/util/calory_calculator.dart';

class WorkOutController extends ControllerMVC {
  factory WorkOutController() => _this ??= WorkOutController._();
  static WorkOutController _this;
  WorkOutController._();

  int get stepCountValue => _WorkoutModel.stepCountValue;
  double get calCounterValue => _WorkoutModel.calCounterValue;
  double get percentageValue =>
      _WorkoutModel.stepCountValue / _WorkoutModel.targetSteps;
  bool get isWorkoutStarted => _WorkoutModel.isWorkoutStared;
  int get targetSteps => _WorkoutModel.targetSteps;
  Duration get workoutDuration => _WorkoutModel.workoutDuration;

  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  int offset = 0;
  Timer _timer;
  int durationSeconds = 0;

  Future<void> initPlatformState() async {
    _pedometer = new Pedometer();
    offset = await _pedometer.pedometerStream.first.catchError((error) {
      print(error.toString());
    });
    print("start from = $offset");
    startListening();
  }

  Future<void> startListening() async {
    startTimer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
    setState(() {
      _WorkoutModel.startWorkout();
    });
   // mock();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        durationSeconds++;
        _WorkoutModel.incrementDuration(Duration(seconds: durationSeconds));
      });
    });
  }

  Future<void> mock() async {
    print("target = ${_WorkoutModel.targetSteps}");
    for (var i = 0; i < _WorkoutModel.targetSteps + 10; i += 10) {
       var cal = CaloriCalculator.calculateEnergyExpenditure(
        176,
        DateTime(1995, 2, 5),
        70,
        0,
        workoutDuration.inSeconds,
        stepCountValue,
        0.5);
      setState(() {
        _WorkoutModel.incrementStepCounter(i);
         _WorkoutModel.incrementCalorieCounter(cal);
      });
      if (!isWorkoutStarted) {
        break;
      }
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  void stopListening() {
    setState(() {
      _WorkoutModel.stopWorkout();
    });
    _subscription.cancel();
    _timer.cancel();
  }

  void _onData(int stepCountValue) async {
    print("OnData pedometer tracking ${stepCountValue - offset}");
    var cal = CaloriCalculator.calculateEnergyExpenditure(
        176,
        DateTime(1995, 2, 5),
        70,
        0,
        workoutDuration.inSeconds,
        stepCountValue,
        0.5);
    setState(() {
      _WorkoutModel.incrementStepCounter(stepCountValue - offset);
      _WorkoutModel.incrementCalorieCounter(cal);
    });
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void setupTargetSteps(int stepPlan) {
    _WorkoutModel.setTargetSteps(stepPlan);
  }

  void replanWorkOut() {
    stopListening();
    durationSeconds = 0;
    _WorkoutModel.incrementDuration(Duration(seconds: 0));
    _WorkoutModel.resetCounter();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => StartScreen()));
  }
}

class _WorkoutModel {
  static bool _isStartedWorkout = false;
  static double _calCounterValue = 0;
  static int _stepCountValue = 0;
  static int _targetSteps = 0;
  static Duration _workoutDuration = Duration();

  static int get stepCountValue => _stepCountValue;
  static double get calCounterValue => _calCounterValue;
  static int get targetSteps => _targetSteps;
  static bool get isWorkoutStared => _isStartedWorkout;
  static Duration get workoutDuration => _workoutDuration;

  static void resetCounter() {
    _stepCountValue = 0;
    _calCounterValue = 0;
  }

  static void incrementDuration(Duration duration) {
    _workoutDuration = duration;
  }

  static void incrementStepCounter(int stepCountValue) {
    _stepCountValue = stepCountValue;
    _calCounterValue = calCounterValue;
  }

  static void incrementCalorieCounter(double calCounterValue) {
    _calCounterValue = calCounterValue;
  }

  static void setTargetSteps(int targetSteps) {
    _targetSteps = targetSteps;
  }

  static void startWorkout() {
    _isStartedWorkout = true;
  }

  static void stopWorkout() {
    _isStartedWorkout = false;
  }
}
