import 'dart:async';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BikingWorkoutSummaryController extends ControllerMVC {
  List<LatLng> latlng = List();
  LatLng currentPosition = LatLng(0, 0);
  final Completer<GoogleMapController> mapController = Completer();

  int index = 0;
  BikingObj selected = BikingObj(
      altitude: 0.0, longitude: 0.0, latitude: 0.0, speed: 0.0, whenSec: 0);

  void initMap(WorkOut workout) {
    (workout.data as Biking).snapShots.forEach((element) {
      currentPosition = LatLng(element.latitude, element.longitude);
      latlng.add(currentPosition);
    });
    mapController.future
        .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: currentPosition,
                zoom: 16.4746,
              ),
            )));
    refresh();
  }

  void changePosition(WorkOut workout, int _index) {
    selected = (workout.data as Biking).snapShots[index];
    currentPosition = LatLng(selected.latitude, selected.longitude);
    mapController.future
        .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: currentPosition,
                zoom: 16.4746,
              ),
            )));
    index = _index;
  }
}
