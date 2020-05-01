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
    }
    return {};
  }

  static Object fromJsonByType(int type, dynamic data) {
    switch (type) {
      case 0:
        return Stairs.fromJson(data.cast<String, dynamic>());
    }
    return {};
  }
}

class Stairs {
  int stairsCount;

  Stairs({this.stairsCount});

  factory Stairs.fromJson(Map<String, dynamic> json) => Stairs(
        stairsCount: json["stairsCount"] == null ? null : json["stairsCount"],
      );

  Map<String, dynamic> toJson() => {
        "stairsCount": stairsCount == null ? null : stairsCount,
      };
}

class Biking {
  double avgSpeed;
  List<Cordinate> cordinates;
}

class Runs {
  double avgSpeed;
  List<Cordinate> cordinates;
}

class Cordinate {
  double longitude;
  double latitude;
  double altitude;
  double speed;
}

enum WorkoutType {
  stairs,
  run,
  bike,
}
