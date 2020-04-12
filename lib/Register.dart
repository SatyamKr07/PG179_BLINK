import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   String username;
   final formkey= GlobalKey<FormState>();
   void submit()
   {
     formkey.currentState.save();
     Navigator.pop(context,username);
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set up your profiel'),),
      body: ListView(children: <Widget>[
        Container(child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top:25),
          child:Center(child: Text('Create a user name',style:TextStyle(fontSize: 25,)),)),
          Padding(padding: EdgeInsets.all(16),
          child:Container(child: Form(key:formkey,child: TextFormField(
            onSaved: (val) => username=val,
            decoration:InputDecoration(border: OutlineInputBorder(),
            labelText:'Username',
            labelStyle:TextStyle(fontSize: 15),
            hintText: "must be atleast three characters")
          ),),)),
          GestureDetector(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
          color: Colors.blue),
          child: Text('Submit',style:TextStyle(color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold)),
          ),
          onTap: submit,)
        ],),)
      ],),
      
    );
  }
}