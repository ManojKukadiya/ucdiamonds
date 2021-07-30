import 'package:flutter/material.dart';
import 'package:ucdiamonds/screens/dashboard.dart';
import 'package:ucdiamonds/screens/settings.dart';
import 'package:ucdiamonds/screens/wallet.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomPosition = 0;

  Function onPressed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showPage(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (pos) {
            setState(() => bottomPosition = pos);
          },
          currentIndex: bottomPosition,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet_giftcard), label: "Wallet"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ]),
    );
  }

  Widget showPage() {
    if (bottomPosition == 0)
      return DashBoard(
        onPressed: () {
          setState(() => bottomPosition = 1);
        },
      );
    if (bottomPosition == 1) return Wallet();
    if (bottomPosition == 2) return Settings();

    return DashBoard();
  }
}
