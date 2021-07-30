import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String appName;
  CustomAppBar(this.appName);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        title: Text(appName),
      ),
    );
  }
}
