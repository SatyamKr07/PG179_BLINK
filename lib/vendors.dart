import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Vendors extends StatefulWidget {
  @override
  _VendorsState createState() => _VendorsState();
}

class _VendorsState extends State<Vendors> {
 

  Widget builditem(DocumentSnapshot d)
  {
    return Container(height: 400,
    child:Column(children: <Widget>[
      Column(
            children: [
               Image.network(
               d['image'],
               width: 600,
               height: 240,
               fit: BoxFit.cover,
           ),
            Container(
           padding: const EdgeInsets.all(32),
           child: Text(
          d['description'].toString(),
          style: TextStyle(fontSize: 18),
         softWrap: true,
    ),
)

            ])
            ]));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Famous vendors here")),
      body : StreamBuilder(stream: Firestore.instance.collection('Vendors').snapshots(),
      builder: (context,snapshot){
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
      },)
      
    );
  }
}