import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:ucdiamonds/utilities/utility.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Settings"),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            SettingItemWidget(
              title: "Edit Profile",
              icon: Icons.supervised_user_circle,
              onPressed: () async {
                Navigator.pushNamed(context, "/EditProfile");
              },
            ),
            SettingItemWidget(
              title: "Tasks",
              icon: Icons.topic_rounded,
              onPressed: () async {
                Navigator.pushNamed(context, "/Tasks");
              },
            ),
            SettingItemWidget(
              title: "Rate & Review",
              icon: Icons.rate_review,
              onPressed: () async {
                await LaunchReview.launch(androidAppId: "com.ucdiamonds");
              },
            ),
            SettingItemWidget(
              title: "About us",
              icon: Icons.info,
              onPressed: () async {
                await Utilities.launchURL("https://gyanbar.com/about/");
              },
            ),
            SettingItemWidget(
              title: "Contact",
              icon: Icons.contact_page,
              onPressed: () async {
                await Utilities.launchURL("https://gyanbar.com/contact-us/");
              },
            ),
            SettingItemWidget(
              title: "Privacy Policty",
              icon: Icons.policy_rounded,
              onPressed: () async {
                await Utilities.launchURL(
                    "https://gyanbar.com/privacy-policy/");
              },
            ),
            SettingItemWidget(
              title: "Logout",
              icon: Icons.logout,
              onPressed: () async {
                Utilities.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData icon;

  SettingItemWidget({this.onPressed, this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
          child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).accentColor,
        ),
        title: Text(title),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).accentColor,
        ),
      )),
    );
  }
}
