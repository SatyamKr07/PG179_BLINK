import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maps/ActivityFeed.dart';
import 'package:maps/Application.dart';
import 'package:maps/RegisteredEvents.dart';
import 'package:maps/add_new_place.dart';
import 'package:maps/locprovider.dart';
import 'package:maps/main.dart';
import 'package:maps/youractivity.dart';
import 'package:provider/provider.dart';
import './Userclass.dart';

class AppDrawer extends StatelessWidget {
  final User u;
  AppDrawer(this.u);
  GoogleSignIn googlesignin = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final placedata = Provider.of<Places>(context, listen: true);

    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text(AppTranslations.of(context).text("profile_details"))),
        Divider(),
        Column(children: <Widget>[
          Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 18,
                ),
                Center(
                  child: Container(
                    height: 67,
                    width: 67,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(u.photourl))),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                    child: Text(
                  u.username,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
                Divider(),
                Center(
                    child: Text(
                  AppTranslations.of(context).text("points"),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
                Center(
                    child: Text(
                  u.points.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
              ]))
        ]),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Your Feeds'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivityFeed()));
          },
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Your Events'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => YourActivity()));
          },
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Registered Events'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisteredEvents()));
          },
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Reports'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Add new places'),
          onTap: () {
            Get.to(AddNewPlace());
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Logout'),
          onTap: () {
            placedata.clear();
            placedata.markers.clear();
            googlesignin?.signOut()?.then((_) {
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => Login()));
              Get.offAll(Login());
            });
          },
        )
      ],
    ));
  }
}
