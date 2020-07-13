import 'dart:convert';

import 'package:ludisy/src/data/forgroundsevices/base_foreground_service.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

class RunningForegroundService extends BaseForegroundService {
  Future<List<RunningObj>> getSavedData() async {
    try {
      var result = await platform.invokeMethod('${getChannelName()}/getdata');
      if (result != null) {
        return List<RunningObj>.from(jsonDecode(result)
            .map((i) => RunningObj.fromJson(i.cast<String, dynamic>()))
            .toList());
      }
    } on Exception catch (e) {
      print("-- mmak ---" + e.toString());
    }
    return [];
  }

  @override
  String getChannelName() {
    return "running";
  }
}
