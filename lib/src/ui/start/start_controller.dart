import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pedometer/pedometer.dart';
import 'package:stairstepsport/src/data/model/user_model.dart';
import 'package:stairstepsport/src/ui/workout/workout_screen.dart';
import 'package:stairstepsport/src/util/shared_pref.dart';

class StartController extends ControllerMVC {
  factory StartController() => _this ??= StartController._();
  static StartController _this;
  StartController._();

  int get stepCountValue => _StartModel.stepCountValue;
  UserModel get userData => _StartModel.userData;

  Difficulty difficulty = Difficulty.easy;

  void init() async {}

  Future<void> initPlatformState() async {
    var userData = await SharedPrefs.getUserData();
    _StartModel.setUserDate(userData);
    Pedometer pedometer = new Pedometer();
    var steps = 0;
    //  await pedometer.pedometerStream.first.catchError((error) {
    //   print(error.toString());
    // });
    print("start from = $steps");
    _StartModel.incrementCounter(steps);
    refresh();
  }

  void setUp() {
    var stepPlan = 0;
    switch (difficulty) {
      case Difficulty.easy:
        stepPlan = 100;
        break;
      case Difficulty.normal:
        stepPlan = 250;
        break;
      case Difficulty.hard:
        stepPlan = 500;
        break;
      case Difficulty.veryhard:
        stepPlan = 1000;
        break;
      case Difficulty.impoible:
        stepPlan = 10000;
        break;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WorkOutScreen(stepPlan)));
  }

  void setDificulty(int value) {
    difficulty = Difficulty.values[value];
  }
}

class _StartModel {
  static int _stepCountValue = 0;
  static UserModel _userData = UserModel();

  static int get stepCountValue => _stepCountValue;
  static UserModel get userData => _userData;

  static void setUserDate(UserModel userData) {
    _userData = userData;
  }

  static void incrementCounter(int stepCountValue) {
    _stepCountValue = stepCountValue;
  }
}

enum Difficulty { easy, normal, hard, veryhard, impoible }
