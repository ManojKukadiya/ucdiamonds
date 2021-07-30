import 'package:flutter/material.dart';
import 'package:ucdiamonds/widgets/my_svg_loaded.dart';

class DashBoardWidget extends StatelessWidget {
  final Function onPressed;
  final String title;
  String image;

  DashBoardWidget(
      {@required this.title, @required this.image, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Container(
          height: 100,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.only(bottom: 8, top: 8, left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MySvgLoader(assetName: image),
              SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
