class User {
  String displayName;
  String photoUrl;
  String userId;
  String gender;
  int weight;
  int bithDate;
  int height;

  User(
      {this.displayName,
      this.photoUrl,
      this.userId,
      this.gender,
      this.weight,
      this.bithDate,
      this.height});

  factory User.fromJson(Map<String, dynamic> json) => User(
      displayName: json["displayName"],
      photoUrl: json["photoUrl"],
      userId: json["user_id"],
      gender: json["gender"],
      weight: json["weight"],
      bithDate: json["bithDate"],
      height: json["height"]);

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "photoUrl": photoUrl,
        "user_id": userId,
        "gender": gender,
        "weight": weight,
        "bithDate": bithDate,
        "height": height
      };

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
}
