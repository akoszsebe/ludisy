import 'package:flutter/material.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/ui/history/history_screen.dart';
import 'package:ludisy/src/ui/login/login_screen.dart';
import 'package:ludisy/src/ui/profile/profile_screen.dart';
import 'package:ludisy/src/ui/settings/settings_screen.dart';
import 'package:ludisy/src/ui/start/start_screen.dart';
import 'package:ludisy/src/ui/workout/rollerskating/rollerskating_workout_screen.dart';
import 'package:ludisy/src/ui/workout/stairing/stairing_workout_screen.dart';
import 'package:ludisy/src/ui/workout/biking/biking_workout_screen.dart';
import 'package:ludisy/src/ui/workoutsummary/biking/biking_workoutsummary_screen.dart';
import 'package:ludisy/src/ui/workoutsummary/rollerskating/rollerskating_workoutsummary_screen.dart';
import 'package:ludisy/src/ui/workoutsummary/stairing/stairing_workoutsummary_screen.dart';

class NavigationModule {
  static void navigateToStartScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(AppRoute(page: StartScreen()));
  }

  static void navigateToStairingWorkoutScreen(
      BuildContext context, int stepsPlaned) {
    Navigator.of(context)
        .push(AppRoute(page: StairingWorkoutScreen(stepsPlaned)));
  }

  static void navigateToBikingWorkoutScreen(BuildContext context) {
    Navigator.of(context).push(AppRoute(page: BikingWorkoutScreen()));
  }

  static void navigateAndReplaceToStairingWorkoutScreen(
      BuildContext context, int stepsPlaned) {
    Navigator.of(context)
        .pushReplacement(AppRoute(page: StairingWorkoutScreen(stepsPlaned)));
  }

  static void navigateToStairingWorkoutSummaryScreen(
      BuildContext context, WorkOut savedWorkout) {
    Navigator.of(context)
        .push(AppRoute(page: StairingWorkoutSummaryScreen(savedWorkout)));
  }

  static void navigateAndReplacToStairingWorkoutSummaryScreen(
      BuildContext context, WorkOut savedWorkout) {
    Navigator.of(context).pushReplacement(
        AppRoute(page: StairingWorkoutSummaryScreen(savedWorkout)));
  }

  static void navigateToBikingWorkoutSummaryScreen(
      BuildContext context, WorkOut savedWorkout) {
    Navigator.of(context)
        .push(AppRoute(page: BikingWorkoutSummaryScreen(savedWorkout)));
  }

  static void navigateAndReplacToBikingWorkoutSummaryScreen(
      BuildContext context, WorkOut savedWorkout) {
    Navigator.of(context).pushReplacement(
        AppRoute(page: BikingWorkoutSummaryScreen(savedWorkout)));
  }

    static void navigateToRollerSkatingWorkoutSummaryScreen(
      BuildContext context, WorkOut savedWorkout) {
    Navigator.of(context)
        .push(AppRoute(page: RollerSkatingWorkoutSummaryScreen(savedWorkout)));
  }

  static void navigateAndReplacToRollerSkatingWorkoutSummaryScreen(
      BuildContext context, WorkOut savedWorkout) {
    Navigator.of(context).pushReplacement(
        AppRoute(page: RollerSkatingWorkoutSummaryScreen(savedWorkout)));
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

  static navigateToRollerSkatingWorkoutScreen(BuildContext context) {
     Navigator.of(context).push(AppRoute(page: RollerSkatingWorkoutScreen()));
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
