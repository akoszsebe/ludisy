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
        "cal": cal,
        "type": type,
        "data": toJsonByType(type, data),
      };

  static Map<String, dynamic> toJsonByType(int type, Object data) {
    switch (type) {
      case 0:
        return (data as Stairs).toJson();
      case 1:
        return (data as Biking).toJson();
    }
    return {};
  }

  static Object fromJsonByType(int type, dynamic data) {
    switch (type) {
      case 0:
        return Stairs.fromJson(data.cast<String, dynamic>());
      case 1:
        return Biking.fromJson(data.cast<String, dynamic>());
    }
    return {};
  }

  static List<WorkOut> listFrom(DataSnapshot snapshot) {
    var result = List<WorkOut>();
    if (snapshot.value != null) {
      try {
        snapshot.value.forEach((k, v) =>
            {result.add(WorkOut.fromJson(v.cast<String, dynamic>()))});
      } catch (Exeption) {
        try {
          snapshot.value.forEach(
              (v) => {result.add(WorkOut.fromJson(v.cast<String, dynamic>()))});
        } catch (Exeption) {}
      }
    }
    return result;
  }
}

// Stiring

class Stairs {
  int stairsCount;
  List<StairingObj> snapShots = [];

  Stairs({this.stairsCount, this.snapShots});

  factory Stairs.fromJson(Map<String, dynamic> json) => Stairs(
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
      distance: json["distance"] == null ? null : json["distance"],
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
        longitude: json["longitude"],
        latitude: json["latitude"],
        altitude: json["altitude"],
        speed: json["speed"],
        whenSec: json["whenSec"],
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

class Runs {
  double avgSpeed;
  List<BikingObj> snapShots;
}

enum WorkoutType {
  stairs,
  run,
  bike,
}
