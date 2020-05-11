import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'dart:convert' show json;

final String _secretsPath = "lib/resources/keys/secrets.json";

class Secrets {
  final String apiKey;
  final String googleAppID;
  final String databaseURL;
  final String fireBaseAppName;

  Secrets(
      {this.apiKey = "",
      this.googleAppID = "",
      this.databaseURL = "",
      this.fireBaseAppName = ""});

  factory Secrets.fromJson(Map<String, dynamic> jsonMap) {
    return Secrets(
        apiKey: jsonMap["apiKey"],
        googleAppID: jsonMap["googleAppID"],
        databaseURL: jsonMap["databaseURL"],
        fireBaseAppName: jsonMap["fireBaseAppName"]);
  }

  static Future<Secrets> load() {
    return rootBundle.loadStructuredData<Secrets>(_secretsPath,
        (jsonStr) async {
      final secret = Secrets.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
