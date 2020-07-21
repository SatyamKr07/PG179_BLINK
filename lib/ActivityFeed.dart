import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import './locprovider.dart';
import 'package:provider/provider.dart';
class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  List<DocumentSnapshot> feeds=[];
  @override
  Widget build(BuildContext context) {
    final placedata=Provider.of<Places>(context,listen: true);
    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.of(context).text("activity_feed")),
      ),
      body:StreamBuilder(stream: Firestore.instance.collection('Feeds').document(placedata.u.userid).collection('2020-04-07 17:59:23.154237').snapshots(),
      builder: (context,snapshot) {
        if(!snapshot.hasData)
        return CircularProgressIndicator();
        else
        {
          feeds=snapshot.data.documents;
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: feeds.length,
          itemBuilder: (context,index) => Column(children:<Widget>[ListTile(leading: CircleAvatar(radius: 40,child: Image.network(feeds[index]['photourl']),),
          title: Text(feeds[index]['text']),trailing: Icon(Icons.delete_forever),),Divider()]));
        }
      },)
      
    );
  }
}