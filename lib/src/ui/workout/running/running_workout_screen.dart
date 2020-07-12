import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/ui/workout/running/running_workout_controller.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/util/style/map_style.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'package:ludisy/src/ui/workout/enum_workout_state.dart';

import 'package:ludisy/src/widgets/workout_active_container.dart';

class RunningWorkoutScreen extends StatefulWidget {
  RunningWorkoutScreen({Key key}) : super(key: key);
  @override
  _RunningWorkoutScreenState createState() => _RunningWorkoutScreenState();
}

class _RunningWorkoutScreenState
    extends BaseScreenState<RunningWorkoutScreen, RunningWorkoutController> {
  _RunningWorkoutScreenState() : super();

  bool isMapCreated = false;
  AppMapStyle _appMapStyle = locator<AppMapStyle>();

  static final LatLng myLocation = LatLng(46.769933, 23.586294);
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    con.init();
    _polyline.add(Polyline(
      polylineId: PolylineId(con.durationSeconds.toString()),
      visible: true,
      points: con.latlng,
      color: AppColors.instance.primary,
    ));
    con.setCustomMapPin();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      con.paused();
    } else if (state == AppLifecycleState.resumed) {
      con.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await con.stopWorkout();
          return true;
        },
        child: BaseView(
            bacgroundColor: AppColors.instance.primaryWithOcupacity50,
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  compassEnabled: false,
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
                        padding: EdgeInsets.only(left: 12, bottom: 40, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            RoundedMiniButton(
                              "back",
                              AppSVGAssets.back,
                              () async {
                                await con.stopWorkout();
                                NavigationModule.pop(context);
                              },
                            ),
                          ],
                        )),
                    Column(
                      children: <Widget>[
                        WorkoutActiveContainer(
                          leftChild: buildIconTextPair(
                              "${Duration(seconds: con.durationSeconds).toString().split('.').first.substring(0, 7)}",
                              AppSVGAssets.stopper),
                          centerChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppSVGAssets.distance,
                                  color: AppColors.instance.iconSecundary,
                                  height: 18,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                ),
                                Text(
                                  "${con.distance.toStringAsFixed(1)}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.instance.primary),
                                ),
                                Text(
                                  "km",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.instance.primary),
                                ),
                                Text(
                                  "Avg. pace",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.instance.textSecundary),
                                ),
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: '${con.avgPace.toStringAsFixed(2)}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            AppColors.instance.textSecundary),
                                  ),
                                  TextSpan(
                                    text: '',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.instance.textSecundary),
                                  ),
                                ]))
                              ]),
                          rightChild: buildIconTextPair(
                              "${con.speed}", AppSVGAssets.speed,
                              secondaryText: " km/h"),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: RoundedContainer(
                                backgroundColor:
                                    AppColors.instance.containerColor,
                                radius: 32.0,
                                height: 48,
                                width: 200,
                                child: Row(children: <Widget>[
                                  buildIconTextPair("${con.calCounterValue}",
                                      AppSVGAssets.cal,
                                      secondaryText: " cal"),
                                  buildIconTextPair("${con.stepCountValue}",
                                      AppSVGAssets.step,
                                      secondaryText: " steps"),
                                ]))),
                        Padding(
                            padding: EdgeInsets.only(bottom: 24, top: 48),
                            child: buildWorkoutButton())
                      ],
                    ),
                  ],
                )
              ],
            )));
  }

  buildWorkoutButton() {
    if (con.workoutState == WorkoutState.running) {
      return RoundedButton(
        "pause",
        AppSVGAssets.pause,
        () {
          con.stopListening();
        },
      );
    } else if (con.workoutState == WorkoutState.paused) {
      return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              "stop",
              AppSVGAssets.stop,
              () async {
                await con.doneWorkout();
              },
            ),
            SizedBox(
              width: 90,
            ),
            RoundedButton(
              "start_running",
              AppSVGAssets.start,
              () {
                con.startListening();
              },
            )
          ]);
    } else {
      return RoundedButton(
        "done",
        AppSVGAssets.done,
        () => NavigationModule
            .navigateAndReplacToRollerSkatingWorkoutSummaryScreen(
                context, con.savedWorkout),
      );
    }
  }

  Widget buildIconTextPair(String text, String iconName,
      {String secondaryText = ""}) {
    return Container(
        width: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                iconName,
                color: AppColors.instance.iconSecundary,
                height: 18,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: text,
                  style: GoogleFonts.montserrat(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.instance.primary),
                ),
                TextSpan(
                  text: secondaryText,
                  style: GoogleFonts.montserrat(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.instance.primary),
                ),
              ]))
            ]));
  }
}