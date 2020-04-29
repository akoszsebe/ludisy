import 'package:ludisy/src/data/model/workout_model.dart';

class User {
  String displayName;
  String photoUrl;
  String userId;
  String gender;
  int weight;
  int bithDate;
  int height;
  List<WorkOut> workOuts;

  User(
      {this.displayName,
      this.photoUrl,
      this.userId,
      this.gender,
      this.weight,
      this.bithDate,
      this.height,
      this.workOuts});

  factory User.fromJson(Map<String, dynamic> json) => User(
      displayName: json["displayName"],
      photoUrl: json["photoUrl"],
      userId: json["user_id"],
      gender: json["gender"],
      weight: json["weight"],
      bithDate: json["bithDate"],
      height: json["height"],
      workOuts: json["workOuts"] == null
          ? null
          : json["workOuts"].map((i) => WorkOut.fromJson(i)).toList());

  Map<String, dynamic> toJson() {
    List<Map> workOuts = this.workOuts != null
        ? this.workOuts.map((i) => i.toJson()).toList()
        : [];
    return {
      "displayName": displayName,
      "photoUrl": photoUrl,
      "user_id": userId,
      "gender": gender,
      "weight": weight,
      "bithDate": bithDate,
      "height": height,
      "workOuts": workOuts
    };
  }

  Map<String, dynamic> toJsonJustUserId() => {"user_id": userId};

  Map<String, dynamic> toJsonWithoutUserId() => {
        "displayName": displayName,
        "photoUrl": photoUrl,
        "user_id": userId,
        "gender": gender,
        "weight": weight,
        "bithDate": bithDate,
        "height": height
      };

  Map<String, dynamic> toJsonJustWorkouts() {
    List<Map> workOuts = this.workOuts != null
        ? this.workOuts.map((i) => i.toJson()).toList()
        : null;
    return {"workOuts": workOuts};
  }
}
