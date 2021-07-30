import 'package:flutter/material.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/screens/redeem_points.dart';
import 'package:ucdiamonds/utilities/utility.dart';

class RedeemPointsList extends StatelessWidget {
  final RedeemWays redeemWays;

  final List paytmTitle = ["Paytm 30", "Paytm 70", "Paytm 200"];
  final List paytmSubtitle = ["5000", "10000", "25000"];

  final List pubgTitle = ["Pubg 40", "Pubg 75"];
  final List pubgSubtitle = ["6000", "11000"];

  final List freeFireTitle = ["FreeFire 50 Diamonds", "FreeFire 100 Diamonds"];
  final List freeFireSubtitle = ["6000", "11000"];

  final List paypalTitle = ["Paypal 1 USD", "Paypal 3 USD"];
  final List paypalSubtitle = ["10000", "25000"];

  final List titlesList = [], subtitlesList = [];

  RedeemPointsList({@required this.redeemWays}) {
    if (RedeemWays.Paytm == redeemWays) {
      titlesList.addAll(paytmTitle);
      subtitlesList.addAll(paytmSubtitle);
    }

    if (RedeemWays.PUBG == redeemWays) {
      titlesList.addAll(pubgTitle);
      subtitlesList.addAll(pubgSubtitle);
    }

    if (RedeemWays.FreeFire == redeemWays) {
      titlesList.addAll(freeFireTitle);
      subtitlesList.addAll(freeFireSubtitle);
    }

    if (RedeemWays.Paypal == redeemWays) {
      titlesList.addAll(paypalTitle);
      subtitlesList.addAll(paypalSubtitle);
    }
  }
  MyAds myAds = MyAds();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Redeem"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: titlesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/RedeemPointRequest",
                          arguments: [subtitlesList[index], titlesList[index]]);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(titlesList[index]),
                        subtitle: Text(subtitlesList[index]),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  );
                }),
          ),
          myAds.bannerAd()
        ],
      ),
    );
  }
}
