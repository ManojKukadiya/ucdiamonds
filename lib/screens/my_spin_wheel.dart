import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/utilities/utility.dart';

import 'wheel/fortune_wheel.dart';
import 'wheel/fortune_wheel_child.dart';
import 'wheel/fortune_wheel_controller.dart';

class MySpinWheel extends StatefulWidget {
  @override
  _MySpinWheelState createState() => _MySpinWheelState();
}

class _MySpinWheelState extends State<MySpinWheel> {
  FortuneWheelController<int> fortuneWheelController = FortuneWheelController();
  FortuneWheelChild currentWheelChild;
  int currentBalance = 0;
  int todaysSpin = 0;
  SharedPreferences _preferences;
   Map<String,dynamic> spinMap;
   bool isLoading = false;
   bool isAddAnable = false;

  MyAds myAds = MyAds();

  @override
  void dispose() {
    myAds.loadRewardAds();
    myAds.disposeBanner();
    super.dispose();
  }

  @override
  void initState() {
    setSharedPref();
    myAds.loadRewardAds();
    myAds.disposeBanner();
    fortuneWheelController.addListener(() {
      if (fortuneWheelController.value == null) return;

      setState(() {
        currentWheelChild = fortuneWheelController.value;
      });

      if (fortuneWheelController.isAnimating) return;

      if (fortuneWheelController.shouldStartAnimation) return;

      if (!fortuneWheelController.isAnimating) {
        increaseSpin();
        Navigator.pushNamed(context, "/AddCoins", arguments: [
          fortuneWheelController.value.value,
          TranasctionType.SPIN
        ]);
      }

      setState(() {
        currentBalance += fortuneWheelController.value.value;
      });
    });
    super.initState();
  }
  increaseSpin(){
    spinMap['toDaysSpin'] += 1;
    _preferences.setString("spinData", jsonEncode(spinMap));
  }
  setSharedPref() async {
    setState(() {
      isLoading = true;
    });
    _preferences = await SharedPreferences.getInstance();
    String spinData = _preferences.getString("spinData");
      DateTime now = DateTime.now();
    if(spinData == null){
     spinMap = {
        'date' : now.toString(),
        'todaysMaxSpin' : 3,
        'toDaysSpin' : 0,
       'lastAdded' : ""
      };
      _preferences.setString("spinData", jsonEncode(spinMap));
      print(jsonEncode(spinMap));
      
    }
    else{
      spinMap = jsonDecode(spinData);
    
      DateTime date = DateTime.parse(spinMap['date']);
       // DateTime date = DateTime.parse("2021-06-25 14:36:27.247356");
       print(now.isAfter(now));
      if(now.isAfter(date) && (date.day != now.day || date.month != now.month || date.year != date.year)){
        spinMap = {
        'date' : now.toString(),
        'todaysMaxSpin' : 3,
        'toDaysSpin' : 0,
          'lastAdded' : ""
      };
       _preferences.setString("spinData", jsonEncode(spinMap));
      }
        print(spinMap);
    }
    setIsAddEnable();

      setState(() {
      isLoading = false;
    });


  }
  increaseMaxSpin(){

     spinMap['todaysMaxSpin'] += 1;
     spinMap['lastAdded'] = DateTime.now().toString();
     print(spinMap.toString());
     setIsAddEnable();
     setState(() {

     });
    _preferences.setString("spinData", jsonEncode(spinMap));
  }
  setIsAddEnable(){
    print(spinMap['lastAdded'] + "at enable");
    if(spinMap['lastAdded'] == ""){
      isAddAnable = true;
      return;
    }
    else{
      DateTime time = DateTime.parse(spinMap['lastAdded']);
      DateTime now = DateTime.now();
      time = time.add(const Duration(hours: 1));
      print(time.difference(now).toString() + "at enable");
      if(time.isBefore(now)){
        isAddAnable = true;
      }
      else{
        isAddAnable = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Utilities.appBar(context, "Spin & Win"),
        body: isLoading ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
                  child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   padding: EdgeInsets.all(24),
                  //   decoration: BoxDecoration(
                  //       color:
                  //           currentBalance.isNegative ? Colors.red : Colors.green,
                  //       borderRadius: BorderRadius.circular(16)),
                  //   child: Text(
                  //     'Current balance: $currentBalance €',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //         fontSize: 18),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 24,
                  // ),
                  // Divider(
                  //   color: Colors.black87,
                  // ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    child: currentWheelChild != null
                        ? currentWheelChild.foreground
                        : Container(),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  SizedBox(
                      width: 350,
                      height: 350,
                      child: FortuneWheel<int>(
                        controller: fortuneWheelController,
                        children: [
                          _createFortuneWheelChild(50),
                          _createFortuneWheelChild(25),
                          _createFortuneWheelChild(10),
                          _createFortuneWheelChild(15),
                          _createFortuneWheelChild(35),
                          _createFortuneWheelChild(5),
                          _createFortuneWheelChild(20),
                        ],
                      )),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                
                      ElevatedButton(
                          onPressed: spinMap['toDaysSpin'] < spinMap['todaysMaxSpin'] ? () {
                            
                            
                              fortuneWheelController.rotateTheWheel();
                            
                          } : null,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Spin & Earn',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                          ElevatedButton(
                          onPressed: !isAddAnable ? null : (){
                            increaseMaxSpin();
                            setState(() {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return  Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          new CircularProgressIndicator(),
                                          SizedBox(width:10),
                                          new Text("Loading"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              new Future.delayed(new Duration(seconds: 5), () async {
                                myAds.showRewardAds();;
                              });

                            });            
                          } ,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Add',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                  myAds.bannerAd()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FortuneWheelChild<int> _createFortuneWheelChild(int value) {
    Color color = value.isNegative ? Colors.red : Colors.green;
    String verb = value.isNegative ? 'Lose' : 'Win';
    int valueString = value.abs();

    return FortuneWheelChild(
        // foreground: _getWheelContentCircle(color, '$verb\n$valueString €'),

        foreground: _getWheelContentCircle(color, '$valueString'),
        value: value);
  }

  Container _getWheelContentCircle(Color backgroundColor, String text) {
    return Container(
      width: 72,
      height: 72,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 4)),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
