import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';

class CaptchScreen extends StatefulWidget {
  @override
  _CaptchScreenState createState() => _CaptchScreenState();
}

class _CaptchScreenState extends State<CaptchScreen> {
  var randomNumber;

  TextEditingController _editingController;

  AuthProvider _authProvider;

  MyAds myAds = MyAds();

  @override
  void initState() {
    generateNumber();
    _editingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    myAds.disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Captcha"),
      body: Consumer<AuthProvider>(
        builder: (context, data, child) {
          _authProvider = data;
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Attempts Left: ${_authProvider.userModel.lastAttemptDate == Utilities.getTimeStamp(onlyDate: true) ? _authProvider.userModel.todayAttemptsCount ?? 0 : "0"}/${Constants.captchAttemptsPerDay}",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          generateNumber();
                        })
                  ],
                ),
                Text(
                  randomNumber,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 88),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _editingController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 48),
                    textAlignVertical: TextAlignVertical.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                        hintText: "Enter Captcha",
                        hintStyle: TextStyle(fontSize: 32),
                        counterText: "",
                        border: OutlineInputBorder())),
                SizedBox(
                  height: 20,
                ),
                generalButton("Submit", () {
                  vailidateCaptcha();
                }, bgColor: Theme.of(context).accentColor),
                myAds.bannerAd()
              ],
            ),
          );
        },
      ),
    );
  }

  vailidateCaptcha() {
    if (_editingController.text == null) {
      Utilities.showSnackBarScaffold(context, "Please Enter value",
          addColor: true);
      return;
    }

    if (_editingController.text != randomNumber) {
      Utilities.showSnackBarScaffold(
          context, "Enter invalid captcha please try again",
          addColor: true);
      return;
    }

    Navigator.pushNamed(context, "/AddCoins", arguments: [
      Constants.pointsPerCaptcha,
      TranasctionType.CAPTCHAPOINTADDED
    ]);
    // Utilities.showSnackBarScaffold(
    //   context,
    //   "Captcha matched",
    // );
  }

  generateNumber() {
    var ran = Random();
    setState(() => randomNumber = '${ran.nextInt(999999)}');
  }
}
