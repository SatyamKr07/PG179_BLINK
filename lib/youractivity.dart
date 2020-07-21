import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:maps/Registeredpeople.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
class YourActivity extends StatefulWidget {
  @override
  _YourActivityState createState() => _YourActivityState();
}

class _YourActivityState extends State<YourActivity> {
  @override
  Widget build(BuildContext context) {
    final placedata=Provider.of<Places>(context,listen: true);
    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.of(context).text("yourevents")),
      ),
      body: StreamBuilder(stream: Firestore.instance.collection('Events').where("ownerid",isEqualTo: placedata.u.userid).snapshots(),
      builder: (context,snapshot) {
        if(!snapshot.hasData)
        return CircularProgressIndicator();
        else
        {
          List<DocumentSnapshot> events=snapshot.data.documents;
          return ListView.builder(padding: EdgeInsets.all(10),itemCount: events.length,itemBuilder:(context,index)=>
          Column(children: <Widget>[
          Container(height:200,width:double.infinity,child:Card(elevation: 10,child:GridTile(
      child:GestureDetector(child:Image.network('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${events[index]['image']}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo',height: 100,),onTap: () {
        
        },),
      footer: GridTileBar(
        title: Column(children:<Widget>[Text(events[index]['GhatName'], textAlign: TextAlign.center,),
        Text("Viewed by: ${events[index]['views']}"),
        Text("Registered by: ${events[index]['registered'].length}")]),
        backgroundColor: Colors.black54,
        leading: IconButton(icon :Icon(Icons.delete_forever),color: Colors.redAccent,onPressed: () {
          
        },),
        trailing:Row(children:<Widget>[Text(AppTranslations.of(context).text("Edit"),style:TextStyle(fontSize: 18)),Icon(Icons.edit)]
      ),
      
    )
    )
    )
    ),
    RaisedButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteredPeople(events[index]['postid'])));
    },child: Container(child:Center(child: Text(AppTranslations.of(context).text("Peoplewhoregistered"),style: TextStyle(fontSize: 18,color: Colors.black87),),),color: Colors.brown,height: 30,))
   
          ]));
        }
      }
      )

      
      ,);

  }
}