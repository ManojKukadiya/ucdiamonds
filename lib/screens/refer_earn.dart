import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/utilities/styles.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/my_svg_loaded.dart';

class ReferEarn extends StatelessWidget {
  AuthProvider _authProvider;
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: Utilities.appBar(context, "Refer & Earn"),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MySvgLoader(
              assetName: "share",
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
                  "Refer you refer friends and earn ${Constants.dialyRewardPoints} for every referral.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                _authProvider.userModel.refferalID.toString(),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            generalButton("Share", () {
              Share.share(
                  "Refer you refer friends and earn ${Constants.dialyRewardPoints} for every referral. Referal Code: ${_authProvider.userModel.refferalID.toString()}");
            }, bgColor: Theme.of(context).accentColor)
          ],
        ),
      ),
    );
  }
}
