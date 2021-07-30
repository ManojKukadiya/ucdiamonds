import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationModel {
  String url;
  String title;
  String message;
  String postId;
  Timestamp timeStamp;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['title'] = title;
    map['message'] = message;
    map['postId'] = postId;
    map["timeStamp"] = FieldValue.serverTimestamp();
    return map;
  }
}
