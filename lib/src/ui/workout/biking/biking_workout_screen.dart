import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/ui/workout/biking/biking_workout_controller.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/util/style/map_style.dart';
import 'package:ludisy/src/util/ui_utils.dart';
import 'package:ludisy/src/widgets/rounded_button.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';

import 'package:ludisy/src/widgets/workout_active_container.dart';

class BikingWorkoutScreen extends StatefulWidget {
  BikingWorkoutScreen({Key key}) : super(key: key);
  @override
  _BikingWorkoutScreenState createState() => _BikingWorkoutScreenState();
}

class _BikingWorkoutScreenState
    extends BaseScreenState<BikingWorkoutScreen, BikingWorkoutController> {
  _BikingWorkoutScreenState() : super();

  GoogleMapController _controller;
  bool isMapCreated = false;
  AppMapStyle _appMapStyle = locator<AppMapStyle>();
  static final LatLng myLocation = LatLng(46.769933, 23.586294);

  @override
  void initState() {
    super.initState();
    con.init();
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

  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 12.4746,
  );

  changeMapMode() {
    setMapStyle(_appMapStyle.mapStyle);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }
    return WillPopScope(
        onWillPop: () async {
          con.stopWorkout();
          return true;
        },
        child: BaseView(
            bacgroundColor: AppColors.instance.primaryWithOcupacity50,
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    isMapCreated = true;
                    changeMapMode();
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
                              () {
                                con.stopWorkout();
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
                                  AppSVGAssets.speed,
                                  color: AppColors.instance.iconSecundary,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                ),
                                Text(
                                  "32",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.instance.primary),
                                ),
                                Text(
                                  "km/h",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.instance.primary),
                                ),
                                Text(
                                  "Avg.",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.instance.textSecundary),
                                ),
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: '10.5',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.instance.textSecundary),
                                  ),
                                  TextSpan(
                                    text: ' km/h',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            AppColors.instance.textSecundary),
                                  ),
                                ]))
                              ]),
                          rightChild: buildIconTextPair(
                              "7.3 km", AppSVGAssets.distance),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: RoundedContainer(
                              backgroundColor:
                                  AppColors.instance.containerColor,
                              radius: 32.0,
                              height: 48,
                              width: 160,
                              child: Row(
                                children: <Widget>[
                                  buildIconTextPair(
                                      "425 m", AppSVGAssets.altitude),
                                  buildIconTextPair("432 cal", AppSVGAssets.cal)
                                ],
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 24, top: 48),
                            child: RoundedButton(
                              "start_biking",
                              AppSVGAssets.pause,
                              () {},
                            ))
                      ],
                    ),
                  ],
                )
              ],
            )));
  }

  Widget buildIconTextPair(String text, String iconName) {
    return Container(
        width: 80,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                iconName,
                color: AppColors.instance.iconSecundary,
                height: 17,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              Text(
                text,
                style: GoogleFonts.montserrat(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.instance.primary),
              ),
            ]));
  }
}
