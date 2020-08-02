import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:maps/GovernmentDetails.dart';
import './locprovider.dart';
import 'package:provider/provider.dart';
class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  Widget builditem(DocumentSnapshot d)
  {
       return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          onTap: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GovernmentDetails(d)),
  );
          },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          d['title'],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(d['budget'], style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(appBar: AppBar(title:Text('Government Projects'),),
   body: StreamBuilder(stream: Firestore.instance.collection('WebPosts').snapshots(),
   builder: (context,snapshot) {
     if(!snapshot.hasData)
     return CircularProgressIndicator();
     else
     {
       return ListView.builder(
         scrollDirection: Axis.vertical,
         itemCount: snapshot.data.documents.length,
         itemBuilder: (context,index) => builditem(snapshot.data.documents[index]),
       );
     }
   },),
   );
  }
}