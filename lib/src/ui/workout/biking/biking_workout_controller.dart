import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/ui/workout/enum_workout_state.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/persitance/dao/workout_dao.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:ludisy/src/data/forgroundsevices/biking_foreground_dervice.dart';
import 'package:ludisy/src/util/logic_utils.dart';

class BikingWorkoutController extends ControllerMVC {
  final UserState userState = locator<UserState>();
  final WorkOutDao _workOutDao = locator<WorkOutDao>();
  final Location location = locator<Location>();
  final BikingForegroundService _bikingForegroundService =
      locator<BikingForegroundService>();

  final Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers = {};
  double calCounterValue = 0;
  WorkoutState workoutState = WorkoutState.paused;
  int durationSeconds = 0;
  int speed = 0;
  int altitude = 0;
  double distance = 0;
  double avgSpeed = 0;
  WorkOut savedWorkout;

  int sampleCount = 0;
  int summSpeed = 0;

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
    _bikingForegroundService.startFGS();
    workoutState = WorkoutState.running;
    refresh();
  }

  Future<void> stopListening() async {
    await _bikingForegroundService.stopFGS();
    if (_timer != null) {
      _timer.cancel();
    }
    workoutState = WorkoutState.paused;
    refresh();
  }

  void startTimer() {
    durationSeconds =
        (DateTime.now().millisecondsSinceEpoch - _startime) ~/ 1000;
    if (_timer != null) {
      _timer.cancel();
    }
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
    speed = (_locationData.speed * 3.6).toInt();
    summSpeed += speed;
    sampleCount++;
    avgSpeed = summSpeed / sampleCount;
    altitude = _locationData.altitude.toInt();
    if (currentPosition.latitude != 0 && currentPosition.longitude != 0) {
      distance += LogicUtils.calculateDistance(
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
                target: LatLng((currentPosition.latitude - 0.004),
                    currentPosition.longitude),
                zoom: 14.4746,
              ),
            )));
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId("marker"),
        position: currentPosition,
        anchor: Offset(0.5, 0.5),
        icon: pinLocationIcon));
    refresh();
  }

  Future<void> resume() async {
    distance = 0;
    sampleCount = 0;
    summSpeed = 0;
    if (workoutState == WorkoutState.running) {
      var savedData = await _bikingForegroundService.getSavedData();
      latlng.clear();
      LatLng prew;
      savedData.forEach((element) {
        if (prew != null) {
          distance += LogicUtils.calculateDistance(prew.latitude,
              prew.longitude, element.latitude, element.longitude);
        }
        currentPosition = LatLng(element.latitude, element.longitude);
        latlng.add(currentPosition);
        speed = (element.speed * 3.6).toInt();
        altitude = element.altitude.toInt();
        prew = currentPosition;
        summSpeed += speed;
        sampleCount++;
        avgSpeed = summSpeed / sampleCount;
      });
      startTimer();
      refresh();
    }
  }

  void paused() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Future<void> stopWorkout() async {
    await stopListening();
    await _bikingForegroundService.removeSavedData();
    workoutState = WorkoutState.finised;
  }

  Future<void> doneWorkout() async {
    distance = 0;
    sampleCount = 0;
    summSpeed = 0;
    if (_timer != null) {
      _timer.cancel();
    }
    var savedData = await _bikingForegroundService.getSavedData();
    await _bikingForegroundService.removeSavedData();
    workoutState = WorkoutState.finised;
    latlng.clear();
    LatLng prew;
    savedData.forEach((element) {
      if (prew != null) {
        distance += LogicUtils.calculateDistance(
            prew.latitude, prew.longitude, element.latitude, element.longitude);
      }
      currentPosition = LatLng(element.latitude, element.longitude);
      latlng.add(currentPosition);
      element.speed = (element.speed * 3.6);
      speed = element.speed.toInt();
      altitude = element.altitude.toInt();
      prew = currentPosition;
      summSpeed += speed;
      sampleCount++;
      avgSpeed = summSpeed / sampleCount;
      element.whenSec = (element.whenSec - _startime) ~/ 1000;
    });
    savedWorkout = WorkOut(
        id: null,
        duration: durationSeconds,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        cal: calCounterValue,
        type: 1,
        data: Biking(distance: distance, snapShots: savedData));
    await _workOutDao.insertWorkOut(savedWorkout);
    userState.addWorkout(savedWorkout);
    refresh();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), AppAssets.biking_marker);
  }
}
