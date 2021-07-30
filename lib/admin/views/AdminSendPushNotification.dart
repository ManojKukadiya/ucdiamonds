import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ucdiamonds/admin/controllers/push_notifications_manager.dart';
import 'package:ucdiamonds/models/push_notification_model.dart';
import 'package:ucdiamonds/utilities/utility.dart';

class AdminSendPushNotificationScreen extends StatefulWidget {
  final Function toggleView;
  AdminSendPushNotificationScreen({this.toggleView});

  @override
  _AdminSendPushNotificationScreenState createState() =>
      _AdminSendPushNotificationScreenState();
}

class _AdminSendPushNotificationScreenState
    extends State<AdminSendPushNotificationScreen> {
  String _title = "";
  String _message = "";
  String _imageURL = "";
  String error = " ";

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<File> imageFile;
  String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Send Push Notification"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          showImage(),
                          ElevatedButton(
                            onPressed: () {
                              pickImagesFromGallery(ImageSource.gallery);
                            },
                            child: Text("Select image"),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter title',
                                labelText: "Title",
                                border: OutlineInputBorder()),
                            initialValue: _message,
                            validator: (val) =>
                                val.length < 3 ? "Enter title" : null,
                            onChanged: (val) {
                              setState(() => _title = val);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: 'Enter message',
                                labelText: "Message",
                                border: OutlineInputBorder()),
                            initialValue: _message,
                            validator: (val) =>
                                val.length < 3 ? "Enter message" : null,
                            onChanged: (val) {
                              setState(() => _message = val);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(

                                // color: Theme.of(context).primaryColor,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor)),
                                child: Text(
                                  "Send Notifications",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      error = "";
                                      isLoading = true;
                                    });

                                    bool status =
                                        await PushNotificationsManager()
                                            .sendNotificationToTopic(
                                                _title, _message);
                                    if (status) {
                                      Utilities.showToastMessage(context,
                                          "Notification send successfully.");
                                      Navigator.pop(context);
                                    } else {
                                      Utilities.showToastMessage(
                                          context, "Notification send failed ");
                                    }

                                    setState(() {
                                      error = "";
                                      isLoading = false;
                                    });
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(fontSize: 22, color: Colors.red),
                          )
                        ],
                      )),
                ),
              ),
            ),
    );
  }

  static Future<String> addPushNotification(
      String title, String message, String postId) {
    final DocumentReference pushNotificationsDocumentReference =
        FirebaseFirestore.instance
            .collection("pushNotifications")
            .doc("notifications");
    try {
      PushNotificationModel pushNotificationModel = PushNotificationModel();
      pushNotificationModel.title = title;
      pushNotificationModel.message = message;
      pushNotificationModel.postId = postId;
      pushNotificationsDocumentReference.set(pushNotificationModel.toMap());
      return null;
    } catch (e) {
      return e;
    }
  }

  static subscribeToGlobalPushNotifications({@required bool yes}) {
    // FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    // if (yes)
    //   firebaseMessaging.subscribeToTopic("All");
    // else
    //   firebaseMessaging.unsubscribeFromTopic("All");
  }

  confirmSendNotification() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text("Are you sure want ot notification?"),
            actions: <Widget>[
              new ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
              new ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      error = "";
                      isLoading = true;
                    });
                  },
                  child: Text("Yes")),
            ],
          );
        });
  }

  pickImagesFromGallery(ImageSource source) {
    setState(() {
      ImagePicker().getImage(source: source).then((onValue) {
        setState(() {
          ImagePicker().getImage(source: source).then((value) {
            imageFile = File(value.path) as Future<File>;
          });
          _imagePath = onValue.path;
          print("_imagePath : " + _imagePath);
        });
      });
    });
  }

  showImage() {
    return FutureBuilder<File>(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.file(snapshot.data, width: 250, height: 250);
          } else if (snapshot.error != null) {
            print("snapshot.error : ${snapshot.error} ");
            return Text("Error Picking Image", textAlign: TextAlign.center);
          } else {
            return Text("No Image Selected", textAlign: TextAlign.center);
          }
        });
  }
}
