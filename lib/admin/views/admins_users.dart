import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ucdiamonds/models/user_model.dart';
import 'package:ucdiamonds/widgets/circle_loading.dart';

class AdminsUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MyCircleLoading();
          }
          if (snapshot.hasData &&
              snapshot.data.docs != null &&
              snapshot.data.docs.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  UserModel stepModel =
                      UserModel.fromMap(snapshot.data.docs[index].data());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text("Name: " +
                            stepModel.name +
                            "\n" +
                            "Email: " +
                            stepModel.email +
                            "\n" +
                            "Phone: " +
                            stepModel.mobile),
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: Text("No use found."));
          }
        },
      ),
    );
  }
}
