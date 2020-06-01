import 'package:ludisy/src/data/model/workout_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:objectdb/objectdb.dart';
import 'package:foreground_service/foreground_service.dart';
import 'dart:io';

class StairingForegroundService {
  static final int serviceRepeateTime = 19; // in seconds
  static int stairs = 0;
  static String dbName = "ludisy_Stairs.db";

  static Future<void> foregroundServiceFunction() async {
    var servicDuration = DateTime.now();
    print("Duration  ${servicDuration.minute} sec");
    _AppForegroundService.updateNotification(
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
    _AppForegroundService.startFGS("Stairing have fun", "Duration 00:00",
        serviceRepeateTime, foregroundServiceFunction);
  }

  static Future<List<StairingObj>> stopFGS() async {
    _AppForegroundService.stopFGS();
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


class _AppForegroundService {
  static void startFGS(String title, String content, int repeatSec,
      Function foregroundServiceFunction) async {
    ///if the app was killed+relaunched, this function will be executed again
    ///but if the foreground service stayed alive,
    ///this does not need to be re-done
    ///
    if (!(await ForegroundService.foregroundServiceIsStarted())) {
      await ForegroundService.setServiceIntervalSeconds(repeatSec);

      //necessity of editMode is dubious (see function comments)
      await ForegroundService.notification.startEditMode();

      await ForegroundService.notification.setTitle(title);
      await ForegroundService.notification.setText(content);

      await ForegroundService.notification.finishEditMode();

      await ForegroundService.startForegroundService(foregroundServiceFunction);
      await ForegroundService.getWakeLock();
    }
  }

  static void stopFGS() async {
    await ForegroundService.stopForegroundService();
  }

  static void updateNotification(String s) {
    ForegroundService.notification.setText(s);
  }
}
