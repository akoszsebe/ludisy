import 'package:flutter/material.dart';
import 'package:ludisy/src/ui/history/history_screen.dart';
import 'package:ludisy/src/ui/login/login_screen.dart';
import 'package:ludisy/src/ui/profile/profile_screen.dart';
import 'package:ludisy/src/ui/settings/settings_screen.dart';
import 'package:ludisy/src/ui/start/start_screen.dart';
import 'package:ludisy/src/ui/workout/stairing/stairing_workout_screen.dart';
import 'package:ludisy/src/ui/workout/biking/biking_workout_screen.dart';
import 'package:ludisy/src/ui/workoutdone/stairing/stairing_workoutdone_screeen.dart';

class NavigationModule {
  static void navigateToStartScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(AppRoute(page: StartScreen()));
  }

  static void navigateToStairingWorkoutScreen(
      BuildContext context, int stepsPlaned) {
    Navigator.of(context)
        .push(AppRoute(page: StairingWorkoutScreen(stepsPlaned)));
  }

  static void navigateToBikingWorkoutScreen(
      BuildContext context) {
    Navigator.of(context)
        .push(AppRoute(page: BikingWorkoutScreen()));
  }

  static void navigateAndReplaceToStairingWorkoutScreen(
      BuildContext context, int stepsPlaned) {
    Navigator.of(context)
        .pushReplacement(AppRoute(page: StairingWorkoutScreen(stepsPlaned)));
  }

  static void navigateToStairingWorkoutDoneScreen(BuildContext context,
      int steps, int stepsPlaned, double cal, int durationSeconds) {
    Navigator.of(context).pushReplacement(AppRoute(
        page: StairingWorkoutDoneScreen(
            steps, stepsPlaned, cal, durationSeconds)));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void navigateToLoginScreenAndRemove(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        AppRoute(page: LoginScreen()), ModalRoute.withName('/'));
  }

  static void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(AppRoute(page: LoginScreen()));
  }

  static void navigateToProfileScreen(BuildContext context) {
    Navigator.push(context, AppRoute(page: ProfileScreen()));
  }

  static void navigateToHistoryScreen(BuildContext context) {
    Navigator.push(context, AppRoute(page: HistoryScreen()));
  }

  static void navigateAndReplaceToHistoryScreen(BuildContext context) {
    Navigator.pushReplacement(context, AppRoute(page: HistoryScreen()));
  }

  static void navigateToSettingsScreen(BuildContext context) {
    Navigator.push(context, AppRoute(page: SettingsScreen()));
  }

  static void navigateAndReplaceToSettingsScreen(BuildContext context) {
    Navigator.pushReplacement(context, AppRoute(page: SettingsScreen()));
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
            child: child,
          ),
          transitionDuration: Duration(milliseconds: 600),
        );
}
