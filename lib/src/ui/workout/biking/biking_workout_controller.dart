import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/ui/workout/enum_workout_state.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';

class BikingWorkoutController extends ControllerMVC {
  final UserState userState = locator<UserState>();
  final WorkOutDao _workOutDao = locator<WorkOutDao>();
  final Location location = locator<Location>();

  final Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers = {};
  double calCounterValue = 0;
  WorkoutState workoutState = WorkoutState.paused;
  int durationSeconds = 0;
  int speed = 0;
  int altitude = 0;
  double distance = 0;
  WorkOut savedWorkout;

  Timer _timer;
  int _startime = 0;
  List<LatLng> latlng = List();
  LatLng currentPosition = LatLng(0, 0);

  BitmapDescriptor pinLocationIcon;

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
      if (durationSeconds % 10 == 0) {
        getLocation();
      }
      refresh();
    });
    getLocation();
  }

  getLocation() async {
    LocationData _locationData = await location.getLocation();
    speed = _locationData.speed.toInt();
    altitude = _locationData.altitude.toInt();
    if (currentPosition.latitude != 0 && currentPosition.longitude != 0) {
      distance += calculateDistance(
              currentPosition.latitude,
              currentPosition.longitude,
              _locationData.latitude,
              _locationData.longitude);
    }
    currentPosition = LatLng(_locationData.latitude, _locationData.longitude);
    latlng.add(currentPosition);
    mapController.future
        .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: currentPosition,
                zoom: 14.4746,
              ),
            )));
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId("marker"),
        position: currentPosition,
        icon: pinLocationIcon));
    refresh();
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

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), AppAssets.biking_marker);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742.0 * asin(sqrt(a));
  }
}
