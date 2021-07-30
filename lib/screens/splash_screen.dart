import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ucdiamonds/models/user_model.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthProvider authProvider;

  checkLogin() async {
    Future.delayed(Duration(seconds: 1), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        UserModel userModel = await authProvider.getUserDetails();
        print("object " + userModel.toMap().toString());
        //Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
        if (userModel.isTaskCompleted) {
          Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/Tasks", (route) => false);
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, "/GoogleAuth", (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/splash.jpg",
              fit: BoxFit.fill,
            )));
  }
}
