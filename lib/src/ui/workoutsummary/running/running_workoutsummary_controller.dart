import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunningWorkoutSummaryController extends ControllerMVC {
  List<LatLng> latlng = List();
  LatLng currentPosition = LatLng(0, 0);
  final Set<Marker> markers = {};
  final Completer<GoogleMapController> mapController = Completer();
  BitmapDescriptor pinLocationIcon;
  int index = 0;
  RunningObj selected = RunningObj(
      altitude: 0.0, longitude: 0.0, latitude: 0.0, speed: 0.0, whenSec: 0);

  Future<void> initMap(WorkOut workout) async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), AppAssets.biking_marker);
    (workout.data as Running).snapShots.forEach((element) {
      latlng.add(LatLng(element.latitude, element.longitude));
    });
    var first = (workout.data as Running).snapShots.first;
    if (first != null) {
      currentPosition = LatLng(first.latitude, first.longitude);
      selected = first;
      markers.add(Marker(
          markerId: MarkerId("marker"),
          position: currentPosition,
          anchor: Offset(0.5, 0.5),
          icon: pinLocationIcon));
    }

    mapController.future
        .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng((currentPosition.latitude - 0.004),
                    currentPosition.longitude),
                zoom: 15.4746,
              ),
            )));
    refresh();
  }

  void changePosition(WorkOut workout, int _index) {
    selected = (workout.data as Running).snapShots[index];
    currentPosition = LatLng(selected.latitude, selected.longitude);
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId("marker"),
        position: currentPosition,
        anchor: Offset(0.5, 0.5),
        icon: pinLocationIcon));
    mapController.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              (currentPosition.latitude - 0.004), currentPosition.longitude),
          zoom: 15.4746,
        ),
      ));
    });
    index = _index;
  }
}
