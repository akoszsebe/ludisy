import 'dart:async';

import 'package:location/location.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/ui/workout/enum_workout_state.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class BikingWorkoutController extends ControllerMVC {
  final UserState userState = locator<UserState>();
  final WorkOutDao _workOutDao = locator<WorkOutDao>();

  Location location = Location();

  double calCounterValue = 0;
  WorkoutState workoutState = WorkoutState.paused;
  int durationSeconds = 0;
  WorkOut savedWorkout;

  Timer _timer;
  int _startime = 0;

  Future<void> init() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _startime = DateTime.now().millisecondsSinceEpoch;
    startListening();
  }

  Future<void> startListening() async {
    startTimer();
    // BikingForegroundService.startFGS();
    workoutState = WorkoutState.running;
    refresh();
    //  mock();
  }

  void stopListening() async {
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
      getLocation();
      refresh();
    });
  }

  getLocation() async {
    LocationData _locationData = await location.getLocation();
    print("${_locationData.toString()}  ${_locationData.speed}");
  }

  Future<void> resume() async {
    if (workoutState == WorkoutState.running) {
      startTimer();
    }
  }

  void paused() {
    _timer.cancel();
  }

  void stopWorkout() {
    stopListening();
    workoutState = WorkoutState.finised;
  }
}
