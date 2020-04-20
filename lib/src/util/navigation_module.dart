import 'package:flutter/material.dart';
import 'package:stairstepsport/src/data/persitance/database.dart';
import 'package:stairstepsport/src/ui/history/history_screen.dart';
import 'package:stairstepsport/src/ui/login/login_screen.dart';
import 'package:stairstepsport/src/ui/profile/profile_screen.dart';
import 'package:stairstepsport/src/ui/settings/settings_screen.dart';
import 'package:stairstepsport/src/ui/start/start_screen.dart';
import 'package:stairstepsport/src/ui/workout/workout_screen.dart';
import 'package:stairstepsport/src/ui/workoutdone/workoutdone_screeen.dart';

class NavigationModule {
  static AppDatabase database;

  static void setAppDatabase(AppDatabase db) {
    database = db;
  }

  static void navigateToStartScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => StartScreen(database)));
  }

  static void navigateToWorkoutScreen(BuildContext context, int stepsPlaned) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => WorkOutScreen(database, stepsPlaned)));
  }

  static void navigateToWorkoutDoneScreen(BuildContext context, int steps,
      int stepsPlaned, double cal, int durationSeconds) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            WorkOutDoneScreen(steps, stepsPlaned, cal, durationSeconds)));
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

  static void navigateToHistoryScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HistoryScreen(database)));
  }

  static void navigateAndReplaceToHistoryScreen(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HistoryScreen(database)));
  }

  static void navigateToSettingsScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SettingsScreen(database)));
  }

  static void navigateAndReplaceToSettingsScreen(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SettingsScreen(database)));
  }
}
