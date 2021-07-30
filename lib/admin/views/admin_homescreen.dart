import 'package:flutter/material.dart';
import 'package:ucdiamonds/admin/views/wallet_history.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/utilities/styles.dart';

import 'AdminSendPushNotification.dart';
import 'admins_users.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            generalButton("Show All Users", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => AdminsUsersScreen()));
            }),
            defalutSizedBox,
            generalButton("Redeem Requests", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => AdminRedeemHistory(
                            tranasctionType: TranasctionType.REDEEM,
                          )));
            }),
            defalutSizedBox,
            generalButton("Push Notifications", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => AdminSendPushNotificationScreen()));
            }),
          ],
        ),
      ),
    );
  }
}
