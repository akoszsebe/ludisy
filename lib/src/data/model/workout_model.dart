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
        cal: json["cal"],
        type: json["type"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "timeStamp": timeStamp,
        "cal": cal,
        "type": type,
        "data": data,
      };
}

class Stairs {
  int stairsCount;

  Stairs({this.stairsCount});
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
