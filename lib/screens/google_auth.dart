import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucdiamonds/providers/auth_provider.dart';
import 'package:ucdiamonds/utilities/constants.dart';
import 'package:ucdiamonds/widgets/my_app_logo.dart';

class GoogleAuth extends StatefulWidget {
  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  AuthProvider authProvider;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Welcome to ${Constants.appname}",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 10,
            ),
            MyAppLogo(),
            SizedBox(
              height: 10,
            ),
            authProvider.loading
                ? CircularProgressIndicator()
                : Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text("LOGIN WITH GOOGLE"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.deepOrangeAccent),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white, fontSize: 15))),
                      onPressed: () {
                        authProvider.googleSignIn(context);
                      },
                    ))
          ],
        ),
      ),
    );
  }
}
