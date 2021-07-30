import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utilities/styles.dart';

class MyImageWidget extends StatelessWidget {
  final appLogoAssetPath = "assets/logo.jpeg";
  final String url;
  final File imageFile;
  final double myWidth;
  final double myHeight;
  final BoxFit boxFit;
  final bool circle;

  MyImageWidget(
      {this.url,
      this.imageFile,
      this.myWidth = 100.0,
      this.myHeight = 100.0,
      this.boxFit = BoxFit.contain,
      this.circle = false});
  @override
  Widget build(BuildContext context) {
    return url == null
        ? Image.asset(
            appLogoAssetPath,
            width: myWidth,
            height: myHeight,
            fit: boxFit,
          )
        : circle
            ? new Container(
                width: myWidth,
                height: myHeight,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColor,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  image: new DecorationImage(
                    image: new CachedNetworkImageProvider(url),
                  ),
                ),
              )
            : url != null
                ? CachedNetworkImage(
                    imageUrl: url,
                    width: myWidth,
                    height: myHeight,
                    fit: boxFit,
                    placeholder: (context, url) => Image.asset(
                      appLogoAssetPath,
                      width: myWidth,
                      height: myHeight,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      appLogoAssetPath,
                      width: myWidth,
                      height: myHeight,
                    ),
                  )
                : Image.file(
                    imageFile,
                    width: myWidth,
                    height: myHeight,
                    fit: boxFit,
                  );
  }
}
