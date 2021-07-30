import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/models/user_model.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/utilities/utility.dart';

class AuthProvider extends ChangeNotifier {
  User user;
  UserModel userModel;

  bool loading = false;

  AuthProvider() {
    userModel = UserModel();
    user = FirebaseAuth.instance.currentUser;
  }

  googleSignIn(BuildContext context) async {
    loading = true;
    notifyListeners();
    GoogleSignIn googleSign = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSign.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    OAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      user = userCredential.user;
      await registerUser();
      Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);

      loading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      loading = false;
      notifyListeners();
      Utilities.showSnackBarScaffold(context, e.message, addColor: true);
    }
  }

  Future<UserModel> getUserDetails() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    userModel = UserModel.fromMap(documentSnapshot.data());

    notifyListeners();
    return userModel;
  }

  registerUser() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel = UserModel.fromMap(documentSnapshot.data());
    } else {
      user = FirebaseAuth.instance.currentUser;
      await getReferralId();
      userModel.uid = user.uid;
      userModel.name = user.displayName;
      userModel.mobile = user.phoneNumber;
      userModel.profileImage = user.photoURL;
      userModel.email = user.email;
      userModel.points = 0;
      documentReference.set(userModel.toMap());
    }

    notifyListeners();
  }

  addReferralPoints(BuildContext context, String referralID) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where("refferalID", isEqualTo: int.parse(referralID))
        .get();

    if (querySnapshot != null && querySnapshot.docs.length > 0) {
      await updatePoints(
          context, TranasctionType.REFERRAL, Constants.referralPoints,
          uid: (querySnapshot.docs[0].data() as Map)["uid"]);
      Utilities.showSnackBarScaffold(
          context, "Successfully applied referral code.");
    } else {
      Utilities.showSnackBarScaffold(context, "Enter valid referral code",
          addColor: true);
    }
    notifyListeners();
  }

  updatePoints(BuildContext context, TranasctionType type, int amount,
      {String uid}) async {
    if (uid == null) {
      uid = user.uid;
    }
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(uid);

    Map<String, dynamic> updateMap = Map();

    if (userModel.points != null) {
      userModel.points += amount;
    } else {
      userModel.points = amount;
    }

    if (TranasctionType.CAPTCHAPOINTADDED == type) {
      updateMap["lastAttemptDate"] = Utilities.getTimeStamp(onlyDate: true);
      if (userModel.lastAttemptDate != Utilities.getTimeStamp(onlyDate: true))
        updateMap["todayAttemptsCount"] = 1;
      else
        updateMap["todayAttemptsCount"] = userModel.todayAttemptsCount + 1 ?? 1;
    }

    if (TranasctionType.DAILYBONUS == type) {
      updateMap["dailyBonusDate"] = Utilities.getTimeStamp(onlyDate: true);
    }

    if (TranasctionType.TASKS == type) {
      updateMap["isTaskCompleted"] = true;
    }

    if (TranasctionType.REFERRAL == type) {
      updateMap["myReferralID"] = user.uid;
    }

    updateMap["points"] = userModel.points;

    await documentReference.update(updateMap);
    await addTransaction(type, amount, uid);
    await getUserDetails();
    Navigator.pushNamed(context, "/Congrats", arguments: amount);
    notifyListeners();
  }

  updateProfile(String name, String mobile, String referral) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    Map<String, dynamic> updateMap = Map();
    updateMap["name"] = name;
    updateMap["mobile"] = mobile;
    updateMap["myReferralID"] = referral;
    await documentReference.update(updateMap);
    notifyListeners();
  }

  redeemRequest(int points, String des) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    Map<String, dynamic> updateMap = Map();
    updateMap["points"] = userModel.points + points;
    await addTransaction(TranasctionType.REDEEM, points, userModel.uid,
        des: des);
    await documentReference.update(updateMap);
    notifyListeners();
  }

  addTransaction(TranasctionType type, int amount, String uid,
      {String des}) async {
    TransactionModel transactionModel = TransactionModel();
    transactionModel.amount = amount;
    transactionModel.timeStamp = Utilities.getTimeStamp();
    if (TranasctionType.REDEEM == type) {
      transactionModel.type = "1";
    } else {
      transactionModel.type = "0";
    }

    if (TranasctionType.CAPTCHAPOINTADDED == type) {
      transactionModel.description = "Captcha Points";
    }
    if (TranasctionType.REDEEM == type) {
      transactionModel.description = "Refferal";
    }
    if (TranasctionType.DAILYBONUS == type) {
      transactionModel.description = "Daily Bonus";
    }
    if (TranasctionType.SPIN == type) {
      transactionModel.description = "Daily Spin";
    }
    if (TranasctionType.TASKS == type) {
      transactionModel.description = "Social Media Follow Tasks";
    }
    if (TranasctionType.REDEEM == type) {
      transactionModel.description = "Redeem ${des ?? ""}";
    }

    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("transactions")
        .doc(uid)
        .collection("transactions");
    await collectionReference.add(transactionModel.toMap());
    notifyListeners();
  }

  getReferralId() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("common").doc("data");
    DocumentSnapshot documentSnapshot = await documentReference.get();
    Map<String, dynamic> map = Map();
    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel.refferalID = (documentSnapshot.data() as Map)["ReferralID"];
      map["ReferralID"] = userModel.refferalID + 1;
      await documentReference.update(map);
    } else {
      userModel.refferalID = 50000;
      map["ReferralID"] = userModel.refferalID;
      await documentReference.set(map);
    }
  }
}
