import 'package:flutter/services.dart';

const platform = const MethodChannel('com.app.ludisy/workout');

abstract class BaseForegroundService {
  String getChannelName();

  Future<void> startFGS() async {
    try {
      await platform.invokeMethod('${getChannelName()}/start');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> stopFGS() async {
    try {
      await platform.invokeMethod('${getChannelName()}/stop');
    } on PlatformException catch (e) {
      print("-- mmak ---" + e.details);
    }
  }

  Future<bool> removeSavedData() async {
    try {
      var result =
          await platform.invokeMethod('${getChannelName()}/removedata');
      return result;
    } on Exception catch (e) {
      print("-- mmak ---" + e.toString());
    }
    return false;
  }
}
