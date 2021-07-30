import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/CircularLoadingWidget.dart';

class ScratchCard extends StatefulWidget {
  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  bool isLoading = false;
  SharedPreferences _preferences;
  Random random = Random();
  Map<String,dynamic> scratchMap ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPrefresnce();
  }
  setPrefresnce() async {
    setState(() {
      isLoading = true;
    });
    _preferences = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String scratchData = _preferences.getString("scratchData");
    print(scratchData);
    if(scratchData == null){
      scratchMap ={
        "date": now.toString(),
        'total':3,
        'cardData' : [<String,dynamic>{
          "isScratched" : false,
          "coin" : random.nextInt(90)+10,
        },
          <String,dynamic>{
            "isScratched" : false,
            "coin" : random.nextInt(90)+10,
          },
          <String,dynamic>{
            "isScratched" : false,
            "coin" : random.nextInt(90)+10,
          }]
      };
      _preferences.setString("scratchData", jsonEncode(scratchMap));
      print(scratchData);
    }
    else{
      scratchMap = jsonDecode(scratchData);
      DateTime date = DateTime.parse(scratchMap['date']);
      // DateTime date = DateTime.parse("2021-06-28 17:56:40.395876");
      if(now.isAfter(date) && (date.day != now.day || date.month != now.month || date.year != date.year)){
        print("change");
        scratchMap = {
          "date": now.toString(),
          'total':3,
          'cardData' : [<String,dynamic>{
            "isScratched" : false,
            "coin" : random.nextInt(90)+10,
          },
            <String,dynamic>{
              "isScratched" : false,
              "coin" : random.nextInt(90)+10,
            },
            <String,dynamic>{
              "isScratched" : false,
              "coin" : random.nextInt(90)+10,
            }]
        };
        _preferences.setString("scratchData", jsonEncode(scratchMap));
      }
    }
    setState(() {
      isLoading = false;
    });
  }
  setScrached(dynamic e){
    e['isScratched'] = true;
    _preferences.setString("scratchData", jsonEncode(scratchMap));
    print(scratchMap);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Scratch Card"),
      body: isLoading ? Center(child: Container(
          child: CircularProgressIndicator())
        ,) :Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.count(crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            ...(scratchMap['cardData'] as List).map((e) {
              return  e['isScratched'] ?Container(


                color: Colors.green,
                child: Center(
                  child: Text(
                    e['coin'].toString(),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                    ),
                  ),
                ),
              ):  InkWell(
                onTap: (){
                  showScratchDialog(e as Map<String,dynamic>);
                },
                child: Scratcher(
                  brushSize: 20,
                  threshold: 40,
                  color: appColor,
                  onChange: (value) => print("Scratch progress: $value%"),
                  onThreshold: () => setScrached(e),
                  child: Container(

                    color: Colors.green,
                    child: Center(
                      child: Text(
                        e['coin'].toString(),
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })
          ],),
          // child: isLoading ? CircularLoadingWidget() : Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //    ...(scratchMap['cardData'] as List).map((e) {
          //      return  e['isScratched'] ?Container(
          //        height: 100,
          //        width: 100,
          //        color: Colors.green,
          //        child: Center(
          //          child: Text(
          //            e['coin'].toString(),
          //            style: TextStyle(
          //                fontSize: 25,
          //                color: Colors.white
          //            ),
          //          ),
          //        ),
          //      ):  Scratcher(
          //        brushSize: 20,
          //        threshold: 40,
          //        image: Image.asset("assets/icons/youtube.png"),
          //        onChange: (value) => print("Scratch progress: $value%"),
          //        onThreshold: () => setScrached(e),
          //        child: Container(
          //          height: 100,
          //          width: 100,
          //        color: Colors.green,
          //        child: Center(
          //          child: Text(
          //            e['coin'].toString(),
          //            style: TextStyle(
          //              fontSize: 25,
          //              color: Colors.white
          //            ),
          //          ),
          //        ),
          //        ),
          //      );
          //    })
          //   ],
          // ),
        ),
      ),
    );
  }
  showScratchDialog(Map<String,dynamic> data){
    print(data);
    showDialog(context: context, builder: (c){
      return  SingleCard(function: setScrache,data: data,);
    });
  }
  void setScrache(){
    setState(() {

    });
    print(scratchMap);
    _preferences.setString("scratchData", jsonEncode(scratchMap));

  }
}
class SingleCard extends StatefulWidget {
  Function function;
  Map<String,dynamic> data;
  int index;
  SingleCard({this.function,this.data,this.index});
  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  setScrached(){
    widget.data['isScratched'] = true;
    widget.function();
    print(widget.data);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: !widget.data['isScratched'] ? Scratcher(
        accuracy: ScratchAccuracy.low,
        brushSize: 30,
        threshold: 40,
        color: appColor,
        onChange: (value) => print("Scratch progress: $value%"),
        onThreshold: () {
          setScrached();
        },
        child: Container(
          height: 200,
          width: 200,
          color: Colors.green,
          child: Center(
            child: Text(
              widget.data['coin'].toString(),
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),
            ),
          ),
        ),
      ): Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.green,
              child: Center(
                child: Text(
                  widget.data['coin'].toString(),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: generalButton("Redeem",(){
                Navigator.pushNamed(context, "/AddCoins", arguments: [
                  widget.data['coin'],
                  TranasctionType.SCRATCH
                ]);
              },bgColor: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
