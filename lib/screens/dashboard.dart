import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';
import 'package:ucdiamonds/ads/my_ads_utils.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/dashboard_widget.dart';
import 'package:ucdiamonds/widgets/my_svg_loaded.dart';

class DashBoard extends StatefulWidget {
  final Function onPressed;

  DashBoard({this.onPressed});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AuthProvider _authProvider;

  MyAds myAds = MyAds();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myAds.disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, data, child) {
        _authProvider = data;
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 200))),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 64,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                _authProvider.user.photoURL,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_authProvider.userModel.name ?? "Guest"),
                                Text(
                                  _authProvider.userModel.email ??
                                      "guest@gmail.com",
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Card(
                            child: Container(
                                height: 40,
                                width: 100,
                                padding: EdgeInsets.only(left: 0, right: 8),
                                child: TextButton.icon(
                                    onPressed: widget.onPressed,
                                    icon: SvgPicture.asset(
                                      "assets/icons/wallet.svg",
                                      height: 20,
                                      width: 20,
                                    ),
                                    label: Text(
                                      _authProvider.userModel.points.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: populateGrid()),
        
                  myAds.bannerAd()
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget populateGrid() { 
    List names = [
      "Captcha Entry",
      "Daily Bonus",
      "Refer & Earn",
      "Spin & Earn",
      "Give Away",
      "Scrach Card"
    ];
    List icons = ["promo", "wallet", "share", "spinning","giveaway", "scrachcard",];
    if (_authProvider.userModel.email == "reddyomer@gmail.com" ||
        _authProvider.userModel.email == "narimetisaigopi@gmail.com") {
      names.add("Admin");
      icons.add("share");
    }
    return Column(
      children: [
        Expanded(
                    child: GridView.builder(
              itemCount: names.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              padding: EdgeInsets.all(16),
              primary: false,
              itemBuilder: (context, index) {
                return DashBoardWidget(
                  title: names[index],
                  image: icons[index],
                  onPressed: () {
                    if (index == 0) {
                      Navigator.pushNamed(context, "/Captcha");
                    }
                    if (index == 1) {
                      Navigator.pushNamed(context, "/DailyBonus");
                    }
                    if (index == 2) {
                      Navigator.pushNamed(context, "/ReferEarn");
                    }
                    if (index == 3) {
                      Navigator.pushNamed(context, "/MySpinWheel");
                    }
                     if (index == 4) {
                      Navigator.pushNamed(context, "/GiveAway");
                    }
                    if (index == 5) {
                      Navigator.pushNamed(context, "/Scratch");
                    }
                    if (index == 6) {
                      Utilities.launchURL("https://www.google.com");
                    }
                    if (index == 7) {
                      Navigator.pushNamed(context, "/Admin");
                    }
                  },
                );
              }),
        ),
         
      ],
    );
  }
}
