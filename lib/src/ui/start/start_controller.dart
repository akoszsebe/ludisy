import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stairstepsport/src/ui/workout/workout_screen.dart';

class StartController extends ControllerMVC {
  factory StartController() => _this ??= StartController._();
  static StartController _this;
  StartController._();

  int get stepCountValue => _StartModel.stepCountValue;

  int offset = 0;

  void setUp(Difficulty difficulty) {
    var stepPlan = 0;
    switch (difficulty) {
      case Difficulty.easy:
        stepPlan = 100;
        break;
      case Difficulty.normal:
        stepPlan = 300;
        break;
      case Difficulty.hard:
        stepPlan = 500;
        break;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WorkOutScreen(stepPlan)));
  }
}

class _StartModel {
  static bool _isStartedWorkout = false;
  static int _stepCountValue = 0;

  static int get stepCountValue => _stepCountValue;
  static bool get isWorkoutStared => _isStartedWorkout;

  static void incrementCounter(int stepCountValue) {
    _stepCountValue = stepCountValue;
  }

  static void startWorkout() {
    _isStartedWorkout = true;
  }

  static void stopWorkout() {
    _isStartedWorkout = false;
  }
}

enum Difficulty { easy, normal, hard }
