import 'package:flutter/material.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/utilities/utility.dart';

enum RedeemWays { Paytm, PUBG, FreeFire, Paypal }

class RedeemPoints extends StatelessWidget {
  final List list = [];

  final List iconList = ["paytm.png", 'pubg.png', 'freefire.png', 'paypal.png'];

  MyAds myAds = MyAds();

  RedeemPoints() {
    RedeemWays.values.forEach((element) {
      list.add(element.toString().replaceAll("RedeemWays.", ""));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Redeem"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/RedeemPointsList",
                          arguments: RedeemWays.values[index]);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(list[index]),
                        // leading: Icon(Icons.attach_money),
                        leading: Image.asset(
                          "assets/icons/${iconList[index]}",
                          height: 24,
                          width: 24,
                          fit: BoxFit.fill,
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {}),
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
