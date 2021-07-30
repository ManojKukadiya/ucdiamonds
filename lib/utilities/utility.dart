import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';

import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ucdiamonds/screens/google_auth.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/CircularLoadingWidget.dart';

class Utilities {
  BuildContext buildContext;
  Utilities(this.buildContext);

  static var formatter = new DateFormat('yyyy-MM-dd HH:mm');

  static getFileName(File file) {
    String name = path.basename(file.path);
    return name;
  }

  static noData() {
    return Center(
      child: Text("No Data"),
    );
  }

  static FilteringTextInputFormatter onlyNumberFormat() {
    return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  }

  static String getDateTime() {
    var now = new DateTime.now();

    return formatter.format(now);
  }

  static Widget appBar(BuildContext context, String title) {
    return AppBar(
      title: Text(
        title,
      ),
      centerTitle: true,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  static showSnackBarScaffold(BuildContext context, String message,
      {bool showToast = false, bool addColor = false}) {
    print("showSnackBar: " + message);

    if (showToast) showToastMessage(context, message);

    var snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 10),
        backgroundColor: addColor ? Colors.red[400] : Colors.green[400]);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // static timeStampToString(TimeStamp timestamp, {bool onlyDate = true}) {
  //   if (timestamp == null) return "";
  //   String date = formatter.format(timestamp.toDate());
  //   if (onlyDate) return date.split(" ")[0];
  //   return date;
  // }

  static String getTimeStamp({bool onlyDate = false}) {
    var now = new DateTime.now();
    String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20
    if (onlyDate) return formatted.split(" ")[0];
    return formatted;
  }

  static int compareTimes(String orderDateTime) {
    DateTime now = new DateTime.now();
    DateTime orderTime = DateTime.parse(orderDateTime);
    print("now $now");
    print("orderTime $orderTime");
    Duration duration = orderTime.difference(now);
    print("duration is ${duration.inDays}");

    return duration.inDays;
  }

  static String preparePaymentSuccessMessage(
      {String name, int amount, bool isCOD}) {
    String message = "";
    // if (isCOD) {
    //   message =
    //       "Congratulations $name Your order successfully placed.\nyour order will be delivered within 3-5 Working days.\nBe ready with ${Constants.rupee}$amount.\n More Info Contact: +918096141623.";
    // } else {
    //   message =
    //       "Congratulations $name You payment is successed.\nyour order will be delivered within 3-5 Working days.\n More Info Contact: +918096141623.";
    // }

    return message;
  }

  // static void shareApp() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   Share.share(
  //       "Download and shop on ${Constants.appname} App.\n https://play.google.com/store/apps/details?id=${packageInfo.packageName}");
  // }

  // static Future<String> getAppLink() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   return "https://play.google.com/store/apps/details?id=${packageInfo.packageName}";
  // }

  // static bool isTodayDate(String compareDate) {
  //   compareDate = compareDate.split(" ")[0];
  //   var todayDate = getTimeStamp().split(" ")[0];
  //   if (todayDate == compareDate) {
  //     return true;
  //   }
  //   return false;
  // }

  // static rateUsOnPlayStore() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String url = "https://play.google.com/store/apps/details?id=" +
  //       packageInfo.packageName;
  //   launchURL(url);
  // }

  static launchURL(String url, {BuildContext context}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (context != null) {
        // showToast(context, "Could not launch $url");
      }
      throw 'Invalid URl $url';
    }
  }

  static Future<bool> hasConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }

    return false;
  }

  static Future<String> showMyDatePicker(BuildContext context,
      {bool returnOnlyDate = true, DateTime selectedDate}) async {
    if (selectedDate == null) selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      return returnOnlyDate
          ? picked.toLocal().toString().split(" ")[0]
          : getTimeStamp(onlyDate: true);

    return null;
  }

  static showToastMessage(BuildContext context, String message) {
    print("showToast: " + message);
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.black, textColor: Colors.white);
  }

  static String basicFormvalidation(String value) {
    if (value == null || value.length == 0) {
      return "Value must not empty";
    }
    return null;
  }

  static String basicEmailvalidation(String value) {
    if (value == null || value.length == 0 || !value.contains("@")) {
      return "Enter valid email address ";
    }
    return null;
  }

  static String basicMobilevalidation(String value) {
    if (value == null || value.length < 10) {
      return "Number must be 10 digits";
    }
    return null;
  }

  static String basicPasswordvalidation(String value) {
    if (value == null || value.length <= 6) {
      return "Password must be more than 6 characters";
    }
    return null;
  }

  static mapToString(Map<String, dynamic> map, {String tag}) {
    var str = json.encode(map);
    if (tag != null) {
      print("$tag >> mapToString: " + str);
    } else {
      print("mapToString: " + str);
    }
  }

  static Uri getUri(String path, {bool wantUser = false}) {
    Uri orgUri = wantUser
        ? Uri.parse(GlobalConfiguration().getString('api_base_user_url'))
        : Uri.parse(GlobalConfiguration().getString('api_base_operator_url'));
    String _path = orgUri.path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: orgUri.scheme,
        host: orgUri.host,
        port: orgUri.port,
        path: _path + path + ".php");
    return uri;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          child: CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }

  static successDialog(BuildContext context, String message,
      {String title = "Alert"}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Okay")),
          ],
        );
      },
    );
  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      loader.remove();
    });
  }

  static logout(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Do you want to logout from the app?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No")),
        TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/Splash", (route) => false);
            },
            child: Text("Yes"))
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static String displayTimeAgoFromTimestamp(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour' : 'An hour';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min' : 'min';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec ';
    } else {
      return 'Just now';
    }
  }
}
