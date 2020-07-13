import 'dart:convert';

import 'package:ludisy/src/data/forgroundsevices/base_foreground_service.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

class RollerSkatingForegroundService extends BaseForegroundService {
  Future<List<RollerSkatingObj>> getSavedData() async {
    try {
      var result = await platform.invokeMethod('${getChannelName()}/getdata');
      if (result != null) {
        return List<RollerSkatingObj>.from(jsonDecode(result)
            .map((i) => RollerSkatingObj.fromJson(i.cast<String, dynamic>()))
            .toList());
      }
    } on Exception catch (e) {
      print("-- mmak ---" + e.toString());
    }
    return [];
  }

  @override
  String getChannelName() {
    return "rollerskating";
  }
}
