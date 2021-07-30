import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySvgLoader extends StatelessWidget {
  String assetName;
  final double height, width;
  Color color;
  MySvgLoader(
      {@required this.assetName,
      this.width = 50,
      this.height = 50,
      this.color}) {
    this.assetName = "assets/icons/$assetName.svg";
  }
  @override
  Widget build(BuildContext context) {
    color == null ? this.color = Theme.of(context).accentColor : color;
    return Container(
        child: SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      color: color,
    ));
  }
}
