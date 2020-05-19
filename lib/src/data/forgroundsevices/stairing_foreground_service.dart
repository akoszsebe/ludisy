import 'package:ludisy/src/data/forgroundsevices/app_forground_service.dart';
import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:objectdb/objectdb.dart';
import 'dart:io';

class StairingForegroundService {
  static final int serviceRepeateTime = 19; // in seconds
  static int stairs = 0;
  static String dbName = "ludisy_Stairs.db";

  static Future<void> foregroundServiceFunction() async {
    var servicDuration = DateTime.now();
    print("Duration  ${servicDuration.minute} sec");
    AppForegroundService.updateNotification(
        "Duration ${servicDuration.minute}");
    Pedometer pedometer = Pedometer();
    // var pedometer = Random();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var db = ObjectDB("${appDocDir.path}/$dbName");

    if (pedometer != null) {
      // var t = pedometer.nextInt(1000) + 100;
      var t = await pedometer.pedometerStream.first;
      var toInsert =
          StairingObj(count: t, whenSec: servicDuration.millisecondsSinceEpoch);
      print("mesured - stairing : ${toInsert.toJson()}");
      db.open();
      db.insert(toInsert.toJson());
      await db.close();
    }
  }

  static void startFGS() {
    AppForegroundService.startFGS("Stairing have fun", "Duration 00:00",
        serviceRepeateTime, foregroundServiceFunction);
  }

  static Future<List<StairingObj>> stopFGS() async {
    AppForegroundService.stopFGS();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var db = ObjectDB("${appDocDir.path}/$dbName");
    await db.open();
    var result = await db.find({});
    db.remove({});
    await db.close();
    return List<StairingObj>.from(result
        .map((i) => StairingObj.fromJson(i.cast<String, dynamic>()))
        .toList());
  }
}
