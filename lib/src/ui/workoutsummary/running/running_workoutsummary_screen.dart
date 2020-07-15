import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:ludisy/src/widgets/container_with_action.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/util/style/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ludisy/src/widgets/app_wigdet_functions.dart';
import 'package:ludisy/src/ui/workoutsummary/running/running_workoutsummary_controller.dart';

class RunningWorkoutSummaryScreen extends StatefulWidget {
  final WorkOut workout;

  RunningWorkoutSummaryScreen(this.workout, {Key key}) : super(key: key);
  @override
  _WorkoutSummaryScreenState createState() => _WorkoutSummaryScreenState();
}

class _WorkoutSummaryScreenState extends BaseScreenState<
    RunningWorkoutSummaryScreen, RunningWorkoutSummaryController> {
  _WorkoutSummaryScreenState() : super();

  final dateformat = new DateFormat('dd-MM-yyyy hh:mm');
  bool isMapCreated = false;
  AppMapStyle _appMapStyle = locator<AppMapStyle>();

  static final LatLng myLocation = LatLng(46.769933, 23.586294);
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    _polyline.add(Polyline(
      polylineId: PolylineId("id"),
      visible: true,
      points: con.latlng,
      width: 4,
      color: AppColors.instance.primary,
    ));
    con.initMap(widget.workout);
  }

  Color containerColor = AppColors.instance.containerColor;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        bacgroundColor: AppColors.instance.primaryWithOcupacity50,
        child: Stack(children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            compassEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            polylines: _polyline,
            markers: con.markers,
            initialCameraPosition: CameraPosition(
              target: myLocation,
              zoom: 12.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_appMapStyle.mapStyle);
              con.mapController.complete(controller);
              setState(() {});
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 12, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RoundedMiniButton(
                        "back",
                        AppSVGAssets.back,
                        () {
                          NavigationModule.pop(context);
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              ContainerWithActionAndLeading(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    width: 64.0,
                    height: 64.0,
                    child: SvgPicture.asset(
                      AppSVGAssets.running,
                      color: AppColors.instance.primary,
                      height: 17,
                      width: 17,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  height: 400,
                  margin: EdgeInsets.only(bottom: 24),
                  child: RoundedContainer(
                      height: 400,
                      width: double.infinity,
                      backgroundColor: containerColor,
                      radius: 32.0,
                      margin: EdgeInsets.only(
                          top: 32, left: 16, right: 16, bottom: 24),
                      child: Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "Summary",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.instance.textPrimary),
                            ),
                            Text(
                              dateformat.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget.workout.timeStamp)),
                              style: GoogleFonts.montserrat(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.instance.textPrimary),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    buildIconTextValue3Pair(
                                        "Duration",
                                        Duration(
                                                seconds:
                                                    widget.workout.duration)
                                            .toString()
                                            .split('.')
                                            .first
                                            .substring(0, 7),
                                        AppSVGAssets.stopper),
                                    buildIconTextValue3Pair(
                                        "Calories",
                                        "${widget.workout.cal.toStringAsFixed(0)} cal",
                                        AppSVGAssets.cal),
                                    buildIconTextValue3Pair(
                                        "Elevation",
                                        "${(widget.workout.data as Running).elevation.toStringAsFixed(0)} m",
                                        AppSVGAssets.altitude),
                                    buildIconTextValue3Pair(
                                        "Distance",
                                        "${(widget.workout.data as Running).distance.toStringAsFixed(1)} km",
                                        AppSVGAssets.distance)
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    buildIconTextValue3Pair(
                                        "Avg Speed",
                                        "${(widget.workout.data as Running).avgSpeed.toStringAsFixed(1)} km/h",
                                        AppSVGAssets.speed),
                                    buildIconTextValue3Pair(
                                        "Avg. Pace",
                                        "${(widget.workout.data as Running).avgPace.toStringAsFixed(1)} km",
                                        AppSVGAssets.stopper),
                                    buildIconTextValue3Pair(
                                        "Avg. cadene",
                                        "${(widget.workout.data as Running).avgCadence.toStringAsFixed(1)} stp/min",
                                        AppSVGAssets.step),
                                    buildIconTextValue3Pair(
                                        "Total",
                                        "${(widget.workout.data as Running).steps} stp",
                                        AppSVGAssets.step)
                                  ],
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 32, right: 32, top: 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  buildColorCircleTextValue3Pair(
                                      "Speed",
                                      con.selected.speed.toStringAsFixed(0) +
                                          " km/h",
                                      Color(0xCC34A853)),
                                  buildColorCircleTextValue3Pair(
                                      "Steps",
                                      con.selected.steps.toStringAsFixed(0) +
                                          " steps",
                                      Color(0xCCa83434)),
                                  buildColorCircleTextValue3Pair(
                                      "Altitude",
                                      con.selected.altitude.toStringAsFixed(0) +
                                          " m",
                                      Color(0xCC475993))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 40, top: 24, left: 10, right: 10),
                                child: Stack(children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.only(bottom: 40),
                                    width: double.infinity,
                                    child: LineChart(
                                      AppChart.lineChartData(linesBarData()),
                                      swapAnimationDuration:
                                          const Duration(milliseconds: 250),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          child: Slider(
                                            activeColor:
                                                AppColors.instance.primary,
                                            inactiveColor: AppColors.instance
                                                .primaryWithOcupacity50,
                                            min: 0,
                                            max: ((widget.workout.data
                                                            as Running)
                                                        .snapShots
                                                        .length -
                                                    1)
                                                .toDouble(),
                                            value: con.index.toDouble(),
                                            onChangeStart: (value) {
                                              setState(() {
                                                containerColor = containerColor
                                                    .withOpacity(0.6);
                                              });
                                            },
                                            onChangeEnd: (value) {
                                              setState(() {
                                                containerColor = containerColor
                                                    .withOpacity(1);
                                              });
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                con.changePosition(
                                                    widget.workout,
                                                    value.toInt());
                                              });
                                            },
                                          ))),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      )),
                  action: RoundedButton(
                    "done",
                    AppSVGAssets.done,
                    () => NavigationModule.pop(context),
                  )),
            ],
          )
        ]));
  }

  List<FlSpot> getStepsSpots() {
    List<FlSpot> spots = List();
    (widget.workout.data as Running).snapShots.forEach((element) {
      spots.add(FlSpot(element.whenSec.toDouble(), element.steps.toDouble()));
    });
    if (spots.isEmpty) {
      spots.add(FlSpot(0, 0));
    }
    return spots;
  }

  List<FlSpot> getSpeedSpots() {
    List<FlSpot> spots = List();
    (widget.workout.data as Running).snapShots.forEach((element) {
      spots.add(FlSpot(element.whenSec.toDouble(), element.speed));
    });
    if (spots.isEmpty) {
      spots.add(FlSpot(0, 0));
    }
    return spots;
  }

  List<FlSpot> getAltitudeSpots() {
    List<FlSpot> spots = List();
    var avgSpeed = (widget.workout.data as Running).avgSpeed;
    var avgAlt = getAvgAltitude((widget.workout.data as Running).snapShots);
    if (avgAlt != 0.0 && avgSpeed != 0.0) {
      var scaleFactor = avgAlt / avgSpeed;
      (widget.workout.data as Running).snapShots.forEach((element) {
        spots.add(FlSpot(
            element.whenSec.toDouble(), (element.altitude) / scaleFactor));
      });
    } else {
      (widget.workout.data as Running).snapShots.forEach((element) {
        spots.add(FlSpot(element.whenSec.toDouble(), element.altitude));
      });
    }
    if (spots.isEmpty) {
      spots.add(FlSpot(0, 0));
    }
    return spots;
  }

  List<LineChartBarData> linesBarData() {
    return [
      AppChart.buildLineChartBarData(getSpeedSpots(), Color(0xCC34A853)),
      AppChart.buildLineChartBarData(getAltitudeSpots(), Color(0xCC475993)),
      AppChart.buildLineChartBarData(getStepsSpots(), Color(0xCCa83434)),
    ];
  }

  double getAvgAltitude(List<RunningObj> snapShots) {
    double avg = 0;
    snapShots.forEach((element) {
      avg += element.altitude;
    });
    if (snapShots.isNotEmpty) {
      return avg / snapShots.length;
    }
    return 0.0;
  }
}
