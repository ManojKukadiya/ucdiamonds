import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/my_svg_loaded.dart';

class DailyBonus extends StatefulWidget {
  @override
  _DailyBonusState createState() => _DailyBonusState();
}

class _DailyBonusState extends State<DailyBonus> {
  AuthProvider _authProvider;

  MyAds myAds = MyAds();

  @override
  void dispose() {
    myAds.disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: Utilities.appBar(context, "Dialy Bonus"),
      body: _authProvider.userModel.dailyBonusDate !=
              Utilities.getTimeStamp(onlyDate: true)
          ? Container(
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
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      decoration: BoxDecoration(),
                      child: Text(
                        "${Constants.dialyRewardPoints}",
                        style: Theme.of(context).textTheme.headline1,
                      )),
                  generalButton("Add Dialy Reward", () async {
                    await _authProvider.updatePoints(
                        context,
                        TranasctionType.DAILYBONUS,
                        Constants.dialyRewardPoints);
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, "/AddCoins", (route) => false,
                    //     arguments: Constants.dialyRewardPoints);
                  }, bgColor: Colors.green),
                  myAds.bannerAd()
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                "You already claimed Today Bonus.\nCome back tomorrow here to earn more points.",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
