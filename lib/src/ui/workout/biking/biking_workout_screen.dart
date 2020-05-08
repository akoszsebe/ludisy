import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ludisy/src/ui/workout/biking/biking_workout_controller.dart';
import 'package:ludisy/src/ui/base/base_screen_state.dart';
import 'package:ludisy/src/ui/base/base_view.dart';
import 'package:ludisy/src/util/assets.dart';
import 'package:ludisy/src/util/navigation_module.dart';
import 'package:ludisy/src/util/style/colors.dart';
import 'package:ludisy/src/util/style/theme_provider.dart';
import 'package:ludisy/src/widgets/rounded_mini_button.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

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
  static final LatLng myLocation = LatLng(37.42796133580664, -122.085749655962);

  @override
  void initState() {
    super.initState();
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 14.4746,
  );

  changeMapMode(String themeName) {
    switch (themeName) {
      case "LIGHT":
        getJsonFile("lib/resources/map/map_style_light.json").then(setMapStyle);
        break;
      case "DARK":
        getJsonFile("lib/resources/map/map_style_dark.json").then(setMapStyle);
        break;
      default:
    }
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (isMapCreated) {
      changeMapMode(themeProvider.themeName);
    }
    return WillPopScope(
        onWillPop: () async {
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
                    changeMapMode(themeProvider.themeName);
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
                                NavigationModule.pop(context);
                              },
                            ),
                          ],
                        )),
                  ],
                )
              ],
            )));
  }
}
