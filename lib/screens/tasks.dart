import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool facebook = false;

  bool youtube = false;

  MyAds myAds = MyAds();

  @override
  void dispose() {
    myAds.disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Tasks"),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await launch("https://www.facebook.com");

                sleep(Duration(seconds: 2));
                setState(() => facebook = true);
              },
              child: Card(
                child: ListTile(
                  title: Text("Follow us on facebook"),
                  subtitle: Text("you will be awarded 30 points"),
                  trailing: Icon(
                    Icons.check_circle_outline_rounded,
                    color: facebook ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await launch(
                    "https://www.youtube.com/channel/UC5LCBw_q1toYCjbozvUqZpw");

                sleep(Duration(seconds: 2));
                setState(() => youtube = true);
              },
              child: Card(
                child: ListTile(
                  title: Text("Subscribe on youtube"),
                  subtitle: Text("you will be awarded 30 points"),
                  trailing: Icon(
                    Icons.check_circle_outline_rounded,
                    color: youtube ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
            Spacer(),
            myAds.bannerAd(),
            Spacer(),
            generalButton(
              "Claim Points",
              youtube & facebook
                  ? () {
                      Navigator.pushNamed(context, "/AddCoins", arguments: [
                        Constants.tasksPoints,
                        TranasctionType.TASKS
                      ]);
                    }
                  : null,
              bgColor: youtube & facebook
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
