import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
class RegisteredPeople extends StatefulWidget {
  final String id;
  RegisteredPeople(this.id);
  @override
  _RegisteredPeopleState createState() => _RegisteredPeopleState();
}

class _RegisteredPeopleState extends State<RegisteredPeople> {
  String postid;
  DocumentSnapshot d;
  List<dynamic> l;
  void getdocument() async 
  {
    print(widget.id.toString());
    d=await Firestore.instance.collection("Registeration").document(widget.id).get();
    print(d['registered']);
    setState(() {
      l=d['registered'];
      print(l.toString());
      
    });

  }
  @override
  void initState()
  {
    super.initState();
    getdocument();
  }
  @override
  Widget build(BuildContext context) {
    postid=widget.id;
    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.of(context).text("Reigestered_people")),),
      body:(d==null) ?
      Center(child:CircularProgressIndicator()):
      ListView.builder(itemCount: l.length,itemBuilder: 
      (context,index) {
      return Column(children:<Widget>[ListTile(leading: CircleAvatar(child: Image.network(l[index]['image']),radius: 40,),
      title: Text(l[index]['Name']),),
      Divider(),
      ]);
      }

      
    ));
  }
 
}