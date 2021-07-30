import 'package:flutter/material.dart';

import '../utilities/styles.dart';

class MyCircleLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(appColor),
        ),
      ),
    );
  }
}
