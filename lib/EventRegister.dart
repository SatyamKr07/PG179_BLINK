import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:maps/Userclass.dart';
import 'package:provider/provider.dart';
import './Animation.dart';
import './locprovider.dart';

class EventRegister extends StatefulWidget {
  final DocumentSnapshot d;
  EventRegister(this.d);

  @override
  _EventRegisterState createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  DocumentSnapshot d;
  List<dynamic> list = [];
  var placedata;
  @override
  Widget build(BuildContext context) {
    placedata = Provider.of<Places>(context, listen: false);
    d = widget.d;
    User user = placedata.user;
    list = d['registered'];
    print(list);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text("Event_details")),
        ),
        body: ListView(children: <Widget>[
          Container(
              child: Column(
            children: <Widget>[
              Container(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${d['image']}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo',
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                AppTranslations.of(context).text(
                                    AppTranslations.of(context)
                                        .text("Register_Event")),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          )),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("name"),
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Text(
                d['name'],
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("phone_number"),
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Text(
                d['number'],
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("Date"),
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Text(
                d['Date'],
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("time"),
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Text(
                d['time'],
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("Description"),
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Text(
                d['description'],
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                AppTranslations.of(context).text("Viewed_by"),
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Text(
                d['views'].toString(),
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ),
          Divider(),
          (!list.contains(user.userid))
              ? RaisedButton(
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.blueAccent,
                    child: Center(
                        child:
                            Text(AppTranslations.of(context).text("Register"))),
                  ),
                  onPressed: () => register(placedata.user),
                )
              : RaisedButton(
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.redAccent,
                    child: Center(
                        child: Text(
                            AppTranslations.of(context).text("Unregister"))),
                  ),
                  onPressed: () => unregister(),
                )
        ]));
  }

  void register(User u) async {
    d.reference.updateData({
      'registered': FieldValue.arrayUnion([u.userid])
    });
    setState(() {});
    DocumentSnapshot d1 = await Firestore.instance
        .collection('Registeration')
        .document(d['postid'])
        .get();
    d1.reference.updateData({
      'registered': FieldValue.arrayUnion([
        {'Name': u.username, 'id': u.userid, 'image': u.photourl}
      ])
    });

    Firestore.instance
        .collection('Feeds')
        .document(d['ownerid'])
        .collection(d["postid"])
        .document(DateTime.now().millisecond.toString())
        .setData({
      "text": "${u.username} has registered for your event in ${d['GhatName']}",
      "timestamp": DateTime.now().toString(),
      "photourl": u.photourl,
      "userid": u.userid,
    });
    DocumentSnapshot d3 =
        await Firestore.instance.collection('Users').document(u.userid).get();
    d3.reference.updateData({'points': FieldValue.increment(20)});
    placedata.setUser(u.userid);
  }

  void unregister() {}
}
