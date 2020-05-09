import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class AppMapStyle {
  String mapStyle = "";

  Future<void> loadMapLightStyle() async {
    mapStyle =
        await rootBundle.loadString("lib/resources/map/map_style_light.json");
  }

  Future<void> loadMapDarkStyle() async {
    mapStyle =
        await rootBundle.loadString("lib/resources/map/map_style_dark.json");
  }
}
