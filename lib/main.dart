import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'routes_generator.dart';
import 'utilities/constants.dart';
import 'utilities/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    readNotification(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: MaterialApp(
        title: Constants.appname,
        initialRoute: '/Splash',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: themeData,
      ),
    );
  }
}

// FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

readNotification(BuildContext context) {
  String title;
  // _firebaseMessaging.configure(
  //   onMessage: (message) async {
  //     title = message["data"]["title"];
  //     print("${message["data"]} readNotification onMessage $title");
  //     Utilities.successDialog(context, message["data"]["body"],
  //         title: message["data"]["title"]);
  //     // navigatorKey.currentState
  //     //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //   },
  //   onLaunch: (message) async {
  //     title = message["data"]["title"];
  //     print("${message["data"]} readNotification onLaunch $title");

  //     // navigatorKey.currentState
  //     //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //   },
  //   onResume: (message) async {
  //     title = message["data"]["title"];
  //     print("${message["data"]} readNotification onResume $title");
  //     // navigatorKey.currentState
  //     //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //   },
  // );

  // _firebaseMessaging.getToken().then((value) {
  //   print("_firebaseMessaging " + value);
  // });
}
