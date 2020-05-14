import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

const platform = const MethodChannel('com.app.ludisy/workout');

class BikingForegroundService {
  static final int serviceRepeateTime = 10; // in seconds
  static String dbName = "ludisy_Biking.db";


  static Future<void> startFGS() async {
    try {
      await platform.invokeMethod('startBiking');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  static Future<void> stopFGS() async {
    try {
      await platform.invokeMethod('stopBiking');
    } on PlatformException catch (e) {
      print("-- mmak ---"+ e.details);
    }
  }

  static Future<List<BikingObj>> getSavedData() async {
    try {
      var result = await platform.invokeMethod('getBikingdata');
      return List<BikingObj>.from(json.decode(result)
        .map((i) => BikingObj.fromJson(i.cast<String, dynamic>()))
        .toList());
    } on PlatformException catch (e) {
      print("-- mmak ---"+ e.details);
    }
    return [];
  }

   static Future<bool> removeSavedData() async {
    try {
      var result = await platform.invokeMethod('removeBikingdata');
      return result;
    } on PlatformException catch (e) {
      print("-- mmak ---"+ e.details);
    }
    return false;
  }
}
