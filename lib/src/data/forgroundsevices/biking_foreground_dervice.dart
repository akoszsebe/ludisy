import 'dart:convert';

import 'package:ludisy/src/data/forgroundsevices/base_foreground_service.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

class BikingForegroundService extends BaseForegroundService {
  Future<List<BikingObj>> getSavedData() async {
    try {
      var result = await platform.invokeMethod('${getChannelName()}/getdata');
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

  @override
  String getChannelName() {
    return "biking";
  }
}
