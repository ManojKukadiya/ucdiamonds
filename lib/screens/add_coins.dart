import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/my_svg_loaded.dart';

class AddCoins extends StatefulWidget {
  final int coins;
  final TranasctionType tranasctionType;

  AddCoins({@required this.coins, @required this.tranasctionType});

  @override
  _AddCoinsState createState() => _AddCoinsState();
}

class _AddCoinsState extends State<AddCoins> {
  AuthProvider _authProvider;

  MyAds myAds = MyAds();

  @override
  void dispose() {
    myAds.disposeBanner();
    myAds.loadInterstitialAd();
    super.dispose();
  }

  @override
  void initState() {
    myAds.loadInterstitialAd();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Add Coins"),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MySvgLoader(
              assetName: "wallet",
              width: 40,
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.green,
            ),
            Container(
                decoration: BoxDecoration(),
                child: Text(
                  "${widget.coins}",
                  style: Theme.of(context).textTheme.headline1,
                )),
            generalButton("Add Coins", () async {
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
              new Future.delayed(new Duration(seconds: 3), () async {

                myAds.showInterstitialAd();
                await _authProvider.updatePoints(
                    context, widget.tranasctionType, widget.coins);
              });

            }, bgColor: Colors.green),
            myAds.bannerAd()
          ],
        ),
      ),
    );
  }
}
