import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utilities/styles.dart';

class MyCircleImageWidget extends StatelessWidget {
  final appLogoAssetPath = "assets/logo.jpeg";
  final String url;
  final File imageFile;
  final double myWidth;
  final double myHeight;
  final BoxFit boxFit;

  MyCircleImageWidget({
    this.url,
    this.imageFile,
    this.myWidth = 100.0,
    this.myHeight = 100.0,
    this.boxFit = BoxFit.contain,
  });
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: myWidth,
      height: myHeight,
      padding: EdgeInsets.all(8),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: appColor,
        // border: Border.all(
        //   color: accentColor,
        //   width: 0,
        // ),
        image: new DecorationImage(
          image: url != null
              ? new CachedNetworkImageProvider(url)
              : AssetImage(appLogoAssetPath),
        ),
      ),
    );
  }
}
