import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/dashboard_widget.dart';
import 'package:ucdiamonds/widgets/my_svg_loaded.dart';

class GiveAway extends StatefulWidget {
  GiveAway({Key key}) : super(key: key);

  @override
  _GiveAwayState createState() => _GiveAwayState();
}

class _GiveAwayState extends State<GiveAway> {
  List names = [
      "Instagram",
      "Facebook",
      "Youtube",
      "Website",
    ];
    List icons = ["instagram", "facebook", "youtube", "website"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Give Away"),
    body: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        MySvgLoader(assetName: "giveaway"),
        SizedBox(
          height: 10,
        ),
        Text("Give Away"),
        Expanded(
          child: GridView.builder(
                    itemCount: names.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                    padding: EdgeInsets.all(16),
                    primary: false,
                    itemBuilder: (context, index) {
                      return InkWell(
            onTap: (){
              switch(index){
                case 0:
                  Utilities.launchURL("https://www.instagram.com/ucdiamondsapp/");
                  break;
                case 1:
                  Utilities.launchURL("https://www.facebook.com/ucdiamondsapp/");
                  break;
                case 2:
                  Utilities.launchURL("https://www.youtube.com/c/BKArmyGaming/");
                  break;
                case 3:
                  Utilities.launchURL("https://gyanbar.com/how-to-mute-discord-on-obs/");
                  break;
                default:
                  break;
              }
            },
            child: Card(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.only(bottom: 8, top: 8, left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                        width: 50,
                        child: Image.asset("assets/icons/${icons[index]}.png")),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      names[index],
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
              ),
            ),
          );
                    }),
        ),
      ],
    ),
    );
  }
}