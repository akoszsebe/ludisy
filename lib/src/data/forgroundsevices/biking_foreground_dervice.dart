import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

const platform = const MethodChannel('com.app.ludisy/workout');

class BikingForegroundService {

  static Future<void> startFGS() async {
    try {
      await platform.invokeMethod('biking/start');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  static Future<void> stopFGS() async {
    try {
      await platform.invokeMethod('biking/stop');
    } on PlatformException catch (e) {
      print("-- mmak ---" + e.details);
    }
  }

  static Future<List<BikingObj>> getSavedData() async {
    try {
      var result = await platform.invokeMethod('biking/getdata');
      if (result != null) {
        return List<BikingObj>.from(jsonDecode(result)
            .map((i) => BikingObj.fromJson(i.cast<String, dynamic>()))
            .toList());
      }
    } on Exception catch (e) {
      print("-- mmak ---" + e.toString());
    }
    return [];
  }

  static Future<bool> removeSavedData() async {
    try {
      var result = await platform.invokeMethod('biking/removedata');
      return result;
    } on Exception catch (e) {
      print("-- mmak ---" + e.toString());
    }
    return false;
  }
}
