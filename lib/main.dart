import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps/location.dart';
import 'package:maps/splash_screen.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import './Register.dart';
import './MyHomepage.dart';
import './Apptranslationdelegate.dart';
import './AppTranslation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './Userclass.dart';

import './location.dart';

Future<Null> main() async {
  runApp(LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => Places(),
        child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.brown,
            accentColor: const Color(0xFFFF5959),
          ),
          home: Login(),
          localizationsDelegates: [
            _newLocaleDelegate,
            //provides localised strings
            GlobalMaterialLocalizations.delegate,
            //provides RTL support
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale("en", ""),
            const Locale("es", ""),
          ],
        ));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAuth = false;
  String token;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String u;
  final FirebaseMessaging _message = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    // _message.getToken().then((tok) {
    //   token = tok;
    // });

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignin(account);
    });
  }

  void handleSignin(GoogleSignInAccount account) {
    if (account != null) {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => MyHomePage(account.id)));
      Get.off(MyHomePage(account.id));
      print('billa');
    }
    // else {
    //   Get.off(SplashScreen());
    // }
  }

  void create() async {
    final user = googleSignIn.currentUser;
    DocumentSnapshot d =
        await Firestore.instance.collection('Users').document(user.id).get();
    if (!d.exists) {
      await Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()))
          .then((username) {
        u = username;
      });
      Firestore.instance.collection('Users').document(user.id).setData({
        "id": user.id,
        "username": u,
        "photo": user.photoUrl,
        "email": user.email,
        "displayname": user.displayName,
        "points": 0,
        "feeds": [],
        "token": token,
      });
    }

    print('hey');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage(user.id)));
  }

  void login() {
    print('hii');
    googleSignIn.signIn().then((_) {
      create();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/g2.jpg'), fit: BoxFit.fill),
          ),
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              // color: Colors.green,
              border: Border.all(color: Colors.red),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      // border: Border.all(
                      //   color: Colors.blue,
                      //   width: 4,
                      // ),
                      color: Colors.blue[100]),
                  child: Text(
                    "Know Your Ghats!",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 250.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.google,
                              color: Color(0xffCE107C),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () => login()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
