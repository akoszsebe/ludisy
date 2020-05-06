// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

    static const Map<String,dynamic> en_US = {
  "history": {
    "steps": "Steps",
    "time": "Time",
    "calories": "Calories",
    "clock": "Clock"
  },
  "login": {
    "wellcome": "Do you need a stair counter?",
    "sign_in": "Sign in",
    "weneedyourdata": "We need some data for calorie counting",
    "congratulation": "Congratulation!",
    "letsdosomesteps": "Let's do some steps"
  },
  "profile": {
    "thisisyourdata": "This is your data"
  },
  "settings": {},
  "start": {
    "start_msg": "Are you ready \n for some exercise?"
  },
  "workout": {},
  "workoutdone": {
    "congratulation": "Congratulation!",
    "success1": "You're tough as Hulk!"
  }
};
  static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US};
}
