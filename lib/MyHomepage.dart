import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps/AppTranslation.dart';
import 'package:maps/Application.dart';
import 'package:maps/Seeotherghats.dart';
import 'package:maps/location.dart';
import 'package:maps/main.dart';
import './AppDrawer.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import './Ghatitem.dart';
import 'package:geolocator/geolocator.dart';
import './location.dart';

class MyHomePage extends StatefulWidget {
  String id;
  MyHomePage(this.id);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double lat;
  double long;
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String label = languagesList[0];
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  FirebaseMessaging firebasemessaging = FirebaseMessaging();
  final googlesignin = GoogleSignIn();
  int count = 0;
  void location() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/rithik-agarwal-scdsos-524ab5e63522.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.ENGLISH);
    AIResponse response = await dialogflow.detectIntent("blue");
    print(response.getListMessage());

    setState(() {
      lat = position.latitude;
      long = position.longitude;
      print(lat);
    });
  }

  @override
  void initState() {
    super.initState();
    location();
    configurepush();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["Hindi"]));
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  void _select(String language) {
    print("dd " + language);
    onLocaleChange(Locale(languagesMap[language]));
    setState(() {
      if (language == "Hindi") {
        label = "हिंदी";
      } else {
        label = language;
      }
    });
  }

  void configurepush() {
    firebasemessaging.configure(
        onLaunch: (Map<String, dynamic> messgae) async {},
        onMessage: (Map<String, dynamic> message) async {
          print(message);
          final String body = message['notification']['body'].toString();
          final String body2 = message['notification']['title'].toString();
          SnackBar snackbar = SnackBar(content: Text("$body by $body2"));
          _scaffoldkey.currentState.showSnackBar(snackbar);
        },
        onResume: (_) async {});
  }

  @override
  Widget build(BuildContext context) {
    final placedata = Provider.of<Places>(context, listen: true);
    if (lat != null && count == 0) {
      placedata.setUser(widget.id);
      placedata.fetch(lat, long);
      print('fetching');
      count = 1;
    }

    return Scaffold(
      key: _scaffoldkey,
      drawer: (lat != null && placedata.user != null)
          ? AppDrawer(placedata.user)
          : Container(),
      appBar: AppBar(
        title: Text(AppTranslations.of(context).text("appbar_title")),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int val) {
              if (val == 0) {
                placedata.clear();
                placedata.markers.clear();
                googlesignin.signOut().then((_) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              }
              if (val == 2) {
                String s;
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'Enter the name or the location of the place'),
                                  onChanged: (val) {
                                    s = val;
                                  },
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeGhats(s)));
                                    },
                                    child: Text(
                                      "Search..",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Logout'),
                value: 0,
              ),
              PopupMenuItem(child: Text('See more Ghats'), value: 2)
            ],
          ),
          PopupMenuButton<String>(
            // overflow menu
            onSelected: _select,
            icon: new Icon(Icons.language, color: Colors.white),
            itemBuilder: (BuildContext context) {
              return languagesList.map<PopupMenuItem<String>>((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: (lat != null && placedata.items.length != 0)
          ? GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: placedata.items.length,
              itemBuilder: (ctx, i) => Ghatitem(
                  placedata.items[i].name,
                  placedata.items[i].imagelink ?? '',
                  placedata.items[i].rating.toString(),
                  placedata.items[i].id),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationInput(lat, long)),
          );
        },
        tooltip: 'Map view',
        child: Icon(Icons.map),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
