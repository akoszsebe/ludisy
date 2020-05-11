import 'package:foreground_service/foreground_service.dart';

class AppForegroundService {
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
