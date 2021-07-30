import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String homeScreenMessage;
  List<dynamic> sliderImages;

  AdminModel({this.homeScreenMessage, this.sliderImages});

  factory AdminModel.fromSnap(DocumentSnapshot documentSnapshot) {
    return AdminModel(
        homeScreenMessage:
            (documentSnapshot.data() as Map)["homeScreenMessage"],
        sliderImages: (documentSnapshot.data() as Map)["sliderImages"]);
  }

  toMap() {
    return {
      "homeScreenMessage": homeScreenMessage,
      "sliderImages": sliderImages
    };
  }
}
