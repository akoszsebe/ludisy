import 'package:foreground_service/foreground_service.dart';
import 'package:pedometer/pedometer.dart';
import 'package:ludisy/src/util/shared_prefs.dart';

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

class StairingForegroundService {
  static final int serviceRepeateTime = 10; // in seconds
  static int servicDuration = 0;
  static int stairs = 0;

  static Future<void> foregroundServiceFunction() async {
    print("Duration  $servicDuration sec");
    _AppForegroundService.updateNotification(
        "Duration ${Duration(seconds: servicDuration).toString().split('.').first.substring(2, 7)}");
    servicDuration += serviceRepeateTime;

    Pedometer pedometer = Pedometer();

    print("null ${pedometer == null}");
    if (pedometer != null) {
      var t = await pedometer.pedometerStream.first;
      print("mesured - steps $t");
      await SharedPrefs.setCurrentWorkout(t.toString());
    }
  }

  static void startFGS(int servicDuration, int pedoOffset) {
    _AppForegroundService.startFGS("Stairing have fun", "Duration 00:00",
        serviceRepeateTime, foregroundServiceFunction);
  }

  static Future<String> stopFGS() async {
    _AppForegroundService.stopFGS();
    return await SharedPrefs.getCurrentWorkout();
  }
}
