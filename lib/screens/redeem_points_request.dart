import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';

class RedeemPointRequest extends StatefulWidget {
  final String points;
  final String des;
  RedeemPointRequest({@required this.points, @required this.des});
  @override
  _RedeemPointRequestState createState() => _RedeemPointRequestState();
}

class _RedeemPointRequestState extends State<RedeemPointRequest> {
  TextEditingController referralCodeTextEditingController =
      TextEditingController();

  AuthProvider _authProvider;

  MyAds myAds = MyAds();

  @override
  void initState() {
    myAds.loadRewardAds();
    super.initState();
  }

  @override
  void dispose() {
    myAds.disposeBanner();
    myAds.disposeRewardAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: Utilities.appBar(context, "Place Redeem Request"),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Requesting : " + widget.des,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${widget.points} will be deducted from your account.",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 20,
            ),
            generalButton("Place Request", () async {
              if (_authProvider.userModel.points < int.parse(widget.points)) {
                Utilities.showSnackBarScaffold(context,
                    "You don't have sufficent points to make this request.");
                return;
              }
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

                await _authProvider.redeemRequest(
                    -int.parse(widget.points), widget.des);
                Navigator.pushNamedAndRemoveUntil(
                    context, "/Home", (route) => false);
                myAds.showRewardAds();
              });

            }),
            myAds.bannerAd()
          ],
        ),
      ),
    );
  }
}
