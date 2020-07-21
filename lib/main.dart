import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps/location.dart';
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
          routes: {LocationInput.routeName: (ctx) => LocationInput()},
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
    _message.getToken().then((tok) {
      token = tok;
    });

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
  }

  void create() async {
    final user = googleSignIn?.currentUser;
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

    print('kutta');
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
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                  'https://images.unsplash.com/photo-1518050947974-4be8c7469f0c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                  fit: BoxFit.fill,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  colorBlendMode: BlendMode.modulate),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    )),
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
                              FontAwesomeIcons.facebookF,
                              color: Color(0xff4754de),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Facebook',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    )),
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
                              FontAwesomeIcons.solidEnvelope,
                              color: Color(0xff4caf50),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Email',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
