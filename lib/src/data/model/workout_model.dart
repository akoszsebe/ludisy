import 'package:firebase_database/firebase_database.dart';

class WorkOut {
  String id; //autgenerated
  int duration;
  int timeStamp;
  double cal;
  int type;
  Object data;

  WorkOut(
      {this.id, this.duration, this.timeStamp, this.cal, this.type, this.data});

  factory WorkOut.fromJson(Map<String, dynamic> json) => WorkOut(
        id: json["id"],
        duration: json["duration"],
        timeStamp: json["timeStamp"],
        cal: json["cal"].toDouble(),
        type: json["type"],
        data: fromJsonByType(json["type"], json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "timeStamp": timeStamp,
        "cal": cal.toDouble(),
        "type": type,
        "data": toJsonByType(type, data),
      };

  static Map<String, dynamic> toJsonByType(int type, Object data) {
    switch (type) {
      case 0:
        return (data as Stairing).toJson();
      case 1:
        return (data as Biking).toJson();
      case 2:
        return (data as RollerSkating).toJson();
      case 3:
        return (data as Running).toJson();
    }
    return {};
  }

  static Object fromJsonByType(int type, dynamic data) {
    switch (type) {
      case 0:
        return Stairing.fromJson(data.cast<String, dynamic>());
      case 1:
        return Biking.fromJson(data.cast<String, dynamic>());
      case 2:
        return RollerSkating.fromJson(data.cast<String, dynamic>());
      case 3:
        return Running.fromJson(data.cast<String, dynamic>());
    }
    return {};
  }

  static List<WorkOut> listFrom(DataSnapshot snapshot) {
    var result = List<WorkOut>();
    if (snapshot.value != null) {
      try {
        snapshot.value.forEach((k, v) =>
            {result.add(WorkOut.fromJson(v.cast<String, dynamic>()))});
      } catch (ex) {
        print(ex);
        try {
          snapshot.value.forEach(
              (v) => {result.add(WorkOut.fromJson(v.cast<String, dynamic>()))});
        } catch (ex) {
          print(ex);
        }
      }
    }
    return result;
  }
}

// Stiring

class Stairing {
  int stairsCount;
  List<StairingObj> snapShots = [];

  Stairing({this.stairsCount, this.snapShots});

  factory Stairing.fromJson(Map<String, dynamic> json) => Stairing(
      stairsCount: json["stairsCount"] == null ? null : json["stairsCount"],
      snapShots: json["snapShots"] == null
          ? []
          : List<StairingObj>.from(json["snapShots"]
              .map((i) => StairingObj.fromJson(i.cast<String, dynamic>()))
              .toList()));

  Map<String, dynamic> toJson() => {
        "stairsCount": stairsCount == null ? null : stairsCount,
        "snapShots": List<dynamic>.from(snapShots.map((x) => x.toJson())),
      };
}

class StairingObj {
  int count;
  int whenSec;

  StairingObj({this.count, this.whenSec});

  factory StairingObj.fromJson(Map<String, dynamic> json) => StairingObj(
        count: json["count"],
        whenSec: json["whenSec"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "whenSec": whenSec,
      };
}

//End Stiring

// Biking

class Biking {
  double distance;
  List<BikingObj> snapShots;

  Biking({this.distance, this.snapShots});

  factory Biking.fromJson(Map<String, dynamic> json) => Biking(
      distance: json["distance"] == null ? null : json["distance"].toDouble(),
      snapShots: json["snapShots"] == null
          ? []
          : List<BikingObj>.from(json["snapShots"]
              .map((i) => BikingObj.fromJson(i.cast<String, dynamic>()))
              .toList()));

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "snapShots": List<dynamic>.from(snapShots.map((x) => x.toJson())),
      };
}

class BikingObj {
  double longitude;
  double latitude;
  double altitude;
  double speed;
  int whenSec;

  BikingObj(
      {this.latitude, this.longitude, this.altitude, this.speed, this.whenSec});

  factory BikingObj.fromJson(Map<String, dynamic> json) => BikingObj(
        longitude:
            json["longitude"] != null ? json["longitude"].toDouble() : 0.0,
        latitude: json["latitude"] != null ? json["latitude"].toDouble() : 0.0,
        altitude: json["altitude"] != null ? json["altitude"].toDouble() : 0.0,
        speed: json["speed"] != null ? json["speed"].toDouble() : 0.0,
        whenSec: json["whenSec"] != null ? json["whenSec"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "altitude": altitude,
        "speed": speed,
        "whenSec": whenSec,
      };
}

// End Biking

// Roller Skating
class RollerSkating {
  double distance;
  List<RollerSkatingObj> snapShots;

  RollerSkating({this.distance, this.snapShots});

  factory RollerSkating.fromJson(Map<String, dynamic> json) => RollerSkating(
      distance: json["distance"] == null ? null : json["distance"].toDouble(),
      snapShots: json["snapShots"] == null
          ? []
          : List<RollerSkatingObj>.from(json["snapShots"]
              .map((i) => RollerSkatingObj.fromJson(i.cast<String, dynamic>()))
              .toList()));

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "snapShots": List<dynamic>.from(snapShots.map((x) => x.toJson())),
      };
}

class RollerSkatingObj {
  double longitude;
  double latitude;
  double speed;
  int whenSec;

  RollerSkatingObj({this.latitude, this.longitude, this.speed, this.whenSec});

  factory RollerSkatingObj.fromJson(Map<String, dynamic> json) =>
      RollerSkatingObj(
        longitude:
            json["longitude"] != null ? json["longitude"].toDouble() : 0.0,
        latitude: json["latitude"] != null ? json["latitude"].toDouble() : 0.0,
        speed: json["speed"] != null ? json["speed"].toDouble() : 0.0,
        whenSec: json["whenSec"] != null ? json["whenSec"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "speed": speed,
        "whenSec": whenSec,
      };
}

// End Roller Skating

//  Running
class Running {
  double distance;
  double elevation;
  int steps;
  List<RunningObj> snapShots;

  Running({this.distance, this.elevation, this.snapShots, this.steps});

  factory Running.fromJson(Map<String, dynamic> json) => Running(
      distance: json["distance"] == null ? null : json["distance"].toDouble(),
      elevation:
          json["elevation"] == null ? null : json["elevation"].toDouble(),
      steps: json["steps"] == null ? null : json["steps"],
      snapShots: json["snapShots"] == null
          ? []
          : List<RunningObj>.from(json["snapShots"]
              .map((i) => RunningObj.fromJson(i.cast<String, dynamic>()))
              .toList()));

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "elevation": elevation == null ? null : elevation,
        "steps": steps == null ? null : steps,
        "snapShots": List<dynamic>.from(snapShots.map((x) => x.toJson())),
      };
}

class RunningObj {
  double longitude;
  double latitude;
  double altitude;
  double speed;
  int steps;
  int whenSec;

  RunningObj(
      {this.latitude,
      this.longitude,
      this.altitude,
      this.speed,
      this.steps,
      this.whenSec});

  factory RunningObj.fromJson(Map<String, dynamic> json) => RunningObj(
        longitude:
            json["longitude"] != null ? json["longitude"].toDouble() : 0.0,
        latitude: json["latitude"] != null ? json["latitude"].toDouble() : 0.0,
        altitude: json["altitude"] != null ? json["altitude"].toDouble() : 0.0,
        speed: json["speed"] != null ? json["speed"].toDouble() : 0.0,
        steps: json["steps"] != null ? json["steps"] : 0,
        whenSec: json["whenSec"] != null ? json["whenSec"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "speed": speed,
        "steps": steps,
        "altitude": altitude,
        "whenSec": whenSec,
      };
}

// End Running

enum WorkoutType {
  stairing,
  biking,
  rollerSkating,
  running,
}
