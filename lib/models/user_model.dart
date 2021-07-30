import 'dart:collection';

import 'package:ucdiamonds/utilities/utility.dart';

class UserModel {
  String uid;
  String profileImage;
  String email;
  String name;
  String password;
  String mobile;
  String age;
  String dob;
  String timeStamp;
  String deviceToken;
  int points;
  int refferalID;
  int todayAttemptsCount;
  String lastAttemptDate;
  String dailyBonusDate;
  String myReferralID;

  bool isTaskCompleted = false;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.mobile,
      this.password,
      this.age,
      this.profileImage,
      this.dob,
      this.points,
      this.todayAttemptsCount,
      this.lastAttemptDate,
      this.dailyBonusDate,
      this.refferalID,
      this.isTaskCompleted,
      this.myReferralID});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    email = map["email"];
    name = map["name"];
    mobile = map["mobile"];
    age = map["age"];
    dob = map["dob"];
    profileImage = map["profileImage"];
    points = map['points'];
    refferalID = map['refferalID'];
    timeStamp = map["timeStamp"];
    todayAttemptsCount = map["todayAttemptsCount"];
    lastAttemptDate = map["lastAttemptDate"];
    dailyBonusDate = map['dailyBonusDate'];
    myReferralID = map['myReferralID'];
    isTaskCompleted = map['isTaskCompleted'] ?? false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new HashMap();
    map["uid"] = uid;
    map["email"] = email;
    map["name"] = name;
    map["mobile"] = mobile;
    map["age"] = age;
    map["dob"] = dob;
    map["profileImage"] = profileImage;
    map["refferalID"] = refferalID;
    map["points"] = points;
    map["timeStamp"] = Utilities.getTimeStamp();
    map["lastAttemptDate"] = lastAttemptDate;
    map["todayAttemptsCount"] = todayAttemptsCount;
    map['dailyBonusDate'] = dailyBonusDate;
    map['myReferralID'] = myReferralID;
    map['isTaskCompleted'] = isTaskCompleted;
    return map;
  }
}
