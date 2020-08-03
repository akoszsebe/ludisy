import 'package:firebase_database/firebase_database.dart';
import 'package:ludisy/src/data/model/workout_model.dart';

class User {
  String displayName;
  String photoUrl;
  String userId;
  String gender;
  int weight;
  DateTime bithDate;
  int height;
  List<WorkOut> workOuts;
  int coundDownSec;

  User(
      {this.displayName,
      this.photoUrl,
      this.userId,
      this.gender,
      this.weight,
      this.bithDate,
      this.height,
      this.workOuts,
      this.coundDownSec});

  factory User.fromJson(Map<String, dynamic> json) => User(
      displayName: json["displayName"],
      photoUrl: json["photoUrl"],
      userId: json["user_id"],
      gender: json["gender"],
      weight: json["weight"],
      coundDownSec: json["coundDownSec"] == null ? 3 : json["coundDownSec"],
      bithDate:
          json["bithDate"] == null ? null : DateTime.parse(json["bithDate"]),
      height: json["height"],
      workOuts: json["workOuts"] == null
          ? []
          : List<WorkOut>.from(json["workOuts"]
              .map((i) => WorkOut.fromJson(i.cast<String, dynamic>()))
              .toList()));

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "photoUrl": photoUrl,
      "user_id": userId,
      "gender": gender,
      "weight": weight,
      "coundDownSec": coundDownSec,
      "bithDate": bithDate.toIso8601String(),
      "height": height,
      "workOuts": List<dynamic>.from(workOuts.map((x) => x.toJson())),
    };
  }

  Map<String, dynamic> toJsonJustUserId() => {"user_id": userId};

  Map<String, dynamic> toJsonWithoutUserId() => {
        "displayName": displayName,
        "photoUrl": photoUrl,
        "user_id": userId,
        "gender": gender,
        "weight": weight,
        "coundDownSec": coundDownSec,
        "bithDate": bithDate.toIso8601String(),
        "height": height
      };

  Map<String, dynamic> toJsonJustWorkouts() {
    List<Map> workOuts = this.workOuts != null
        ? this.workOuts.map((i) => i.toJson()).toList()
        : null;
    return {"workOuts": workOuts};
  }

  factory User.fromSnapshot(DataSnapshot snapshot) {
    List<WorkOut> workouts = List();
    try {
      snapshot.value["workOuts"].forEach((k, v) =>
          {workouts.add(WorkOut.fromJson(v.cast<String, dynamic>()))});
    } catch (Exeption) {
      try {
        snapshot.value["workOuts"].forEach(
            (v) => {workouts.add(WorkOut.fromJson(v.cast<String, dynamic>()))});
      } catch (Exeption) {}
    }
    return User(
        displayName: snapshot.value["displayName"],
        photoUrl: snapshot.value["photoUrl"],
        userId: snapshot.value["user_id"],
        gender: snapshot.value["gender"],
        weight: snapshot.value["weight"],
        coundDownSec: snapshot.value["coundDownSec"] == null
            ? 3
            : snapshot.value["coundDownSec"],
        bithDate: snapshot.value["bithDate"] == null
            ? null
            : DateTime.parse(snapshot.value["bithDate"]),
        height: snapshot.value["height"],
        workOuts: workouts);
  }
}
