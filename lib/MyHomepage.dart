import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps/location.dart';
import 'package:maps/main.dart';
import './AppDrawer.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import './Ghatitem.dart';
import 'package:geolocator/geolocator.dart';
import './location.dart';
import './Userclass.dart';
class MyHomePage extends StatefulWidget {
  String id;
  MyHomePage(this.id);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double lat;
  double long;
  final _scaffoldkey=GlobalKey<ScaffoldState>();
  FirebaseMessaging firebasemessaging=FirebaseMessaging();
  final googlesignin=GoogleSignIn();
  int count=0;
   void location() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    setState(() {
        lat=position.latitude;
    long=position.longitude;
    print(lat);
     
    });
}
@override
void initState()
{
  super.initState();
  location();
  configurepush();

}
void configurepush()
{
  firebasemessaging.configure(
    onLaunch: (Map<String,dynamic> messgae) async{
      
    },
    onMessage: (Map<String,dynamic> message) async {
      print(message);
      final String body= message['notification']['body'].toString();
      final String body2=message['notification']['title'].toString();
      SnackBar snackbar=SnackBar(content: Text("$body by $body2"));
      _scaffoldkey.currentState.showSnackBar(snackbar);

    },
    onResume: (_) async {}


  );
}
  @override
  Widget build(BuildContext context) {
     final placedata=Provider.of<Places>(context,listen: true);
      if(lat != null && count==0)
     {
    placedata.setUser(widget.id);
    placedata.fetch(lat, long);
    print('fetching');
     count=1;
     }

    return Scaffold(
      key: _scaffoldkey,
      drawer: (lat != null && placedata.user != null) ? AppDrawer(placedata.user):Container(),
      appBar: AppBar(
       title: Text('Ghats near your location'),
        actions: <Widget>[
        PopupMenuButton(
          onSelected: (int val) {
            if(val == 0)
            {placedata.clear();
            placedata.markers.clear();
             googlesignin.signOut().then((_) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
             }); 
             
          }
          },
          icon: Icon(Icons.more_vert),itemBuilder: (_)
          => [PopupMenuItem(child: Text('Logout'),value: 0,),],
        ),
        ],
      ),
      body:(lat != null && placedata.items.length != 0) ? 
       GridView.builder(
padding: const EdgeInsets.all(10.0),
        itemCount: placedata.items.length,
        itemBuilder: (ctx,i) => Ghatitem(placedata.items[i].name,placedata.items[i].imagelink,placedata.items[i].rating.toString(),placedata.items[i].id),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 3/2,crossAxisSpacing: 10,mainAxisSpacing: 10),
      )
      :Center(child:CircularProgressIndicator())
        ,
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            LocationInput.routeName
          );},
        
        tooltip: 'Map view',
        child: Icon(Icons.map),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
