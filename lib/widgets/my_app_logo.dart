import 'package:flutter/material.dart';

class MyAppLogo extends StatelessWidget {
  final double width;
  final double height;

  MyAppLogo({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: Image.asset(
          "assets/logo.jpeg",
        ));
  }
}
