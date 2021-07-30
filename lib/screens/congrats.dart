import 'package:flutter/material.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/utilities/styles.dart';

class Congrats extends StatefulWidget {
  int points;

  Congrats({@required this.points});

  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  MyAds myAds = MyAds();

  @override
  void initState() {
    myAds.loadRewardAds();
    myAds.disposeRewardAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Congrations ${widget.points} points \nAdded to your wallet.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // Text(
            //   "Your wallet balance is \n 10",
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context)
            //       .textTheme
            //       .headline2
            //       .copyWith(color: Colors.green, fontWeight: FontWeight.bold),
            // ),
            SizedBox(
              height: 30,
            ),
            generalButton("Go Home", () {
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

                Navigator.pushNamedAndRemoveUntil(
                    context, "/Home", (route) => false);
                myAds.showRewardAds();
              });

            }, bgColor: Colors.lightGreen),
            myAds.bannerAd()
          ],
        ),
      ),
    );
  }
}
