import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps/MyHomepage.dart';
import 'package:maps/alleventsdisplay.dart';
import 'package:maps/main.dart';

import 'auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignin(account);
    });
  }

  void handleSignin(GoogleSignInAccount account) {
    if (account != null) {
      Future.delayed(Duration(seconds: 1)).then(
        (value) => Get.off(MyHomePage(account.id)),
      );
    } else {
      Get.off(Login());
    }
  }

  initScreen(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/g2.jpg"),
            fit: BoxFit.fill,
          ),
          // color: Colors.teal.withOpacity(.9),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Text(
                  'Ghats',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                  ),
                ),
              ),
              Text(
//                'An app for all your college needs',
                '"Know your Ghats!"',

//                'enriching college experience',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.deepOrange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
