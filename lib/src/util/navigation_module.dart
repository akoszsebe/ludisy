import 'package:flutter/material.dart';
import 'package:stairstepsport/src/ui/login/login_screen.dart';
import 'package:stairstepsport/src/ui/profile/profile_screen.dart';
import 'package:stairstepsport/src/ui/start/start_screen.dart';
import 'package:stairstepsport/src/ui/workout/workout_screen.dart';
import 'package:stairstepsport/src/ui/workoutdone/workoutdone_screeen.dart';

class NavigationModule {
  static void navigateToStartScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => StartScreen()));
  }

  static void navigateToWorkoutScreen(BuildContext context, int stepsPlaned) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WorkOutScreen(stepsPlaned)));
  }

  static void navigateToWorkoutDoneScreen(BuildContext context, int steps,
      int stepsPlaned, double cal, Duration duration) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            WorkOutDoneScreen(steps, stepsPlaned, cal, duration)));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }), ModalRoute.withName('/'));
  }

  static void navigateToProfileScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }
}
