import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/styles.dart';

import 'wallet_history.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> with TickerProviderStateMixin {
  TabController tabController;
  AuthProvider _authProvider;
  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              toolbarHeight: 250,
              title: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    "assets/icons/wallet.svg",
                    color: Colors.white,
                    height: 54,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _authProvider.userModel.points.toString(),
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/RedeemPoints");
                      },
                      child: Text("Redeem Points"))

                  // InkWell(
                  //   onTap: () {

                  //   },
                  //   child: Text(
                  //     "Redeem Points",
                  //     style: Theme.of(context).textTheme.headline6.copyWith(
                  //         decoration: TextDecoration.underline, fontSize: 14),
                  //   ),
                  // )
                ],
              ),
              bottom: new TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    text: "Transactions",
                  ),
                  Tab(
                    text: "Redeem",
                  )
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                WalletHistory(
                  tranasctionType: TranasctionType.CAPTCHAPOINTADDED,
                ),
                WalletHistory(tranasctionType: TranasctionType.REDEEM)
              ],
            )));
  }
}
