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
    Navigator.of(context)
        .pushReplacement(AppRoute(page: StartScreen(database)));
  }

  static void navigateToWorkoutScreen(BuildContext context, int stepsPlaned) {
    Navigator.of(context)
        .pushReplacement(AppRoute(page: WorkOutScreen(database, stepsPlaned)));
  }

  static void navigateToWorkoutDoneScreen(BuildContext context, int steps,
      int stepsPlaned, double cal, int durationSeconds) {
    Navigator.of(context).pushReplacement(AppRoute(
        page: WorkOutDoneScreen(steps, stepsPlaned, cal, durationSeconds)));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        AppRoute(page: LoginScreen()), ModalRoute.withName('/'));
  }

  static void navigateToProfileScreen(BuildContext context) {
    Navigator.push(context, AppRoute(page: ProfileScreen()));
  }

  static void navigateToHistoryScreen(BuildContext context) {
    Navigator.push(context, AppRoute(page: HistoryScreen(database)));
  }

  static void navigateAndReplaceToHistoryScreen(BuildContext context) {
    Navigator.pushReplacement(context, AppRoute(page: HistoryScreen(database)));
  }

  static void navigateToSettingsScreen(BuildContext context) {
    Navigator.push(context, AppRoute(page: SettingsScreen(database)));
  }

  static void navigateAndReplaceToSettingsScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, AppRoute(page: SettingsScreen(database)));
  }
}

class AppRoute extends PageRouteBuilder {
  final Widget page;
  AppRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                    child: child,
                  )),
          transitionDuration: Duration(milliseconds: 500),
        );
}
