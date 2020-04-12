import 'package:flutter/material.dart';
import './Userclass.dart';
class AppDrawer extends StatelessWidget {
  final User u;
  AppDrawer(this.u);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(children: <Widget>[
        AppBar(title:Text("Profile Details")),
        Divider(),
        Column(
          children:<Widget>[
            Container(
            height:200,
            width:200,
            decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.circular(10)),
            child:Column(children:<Widget>
            [
              SizedBox(height: 18,),
              Center(child: Container(height: 67,
              width: 67,
              decoration: BoxDecoration(shape: 
              BoxShape.circle,
              image: new DecorationImage(fit:BoxFit.cover,
              image:NetworkImage(u.photourl))),),),
              SizedBox(height: 12,),
              Center(child: Text(u.username,style: TextStyle(color: Colors.yellowAccent,fontSize: 18),)),
              Divider(),
              Center(child: Text("Points",style: TextStyle(color: Colors.redAccent,fontSize: 20),)),
               Center(child: Text(u.points.toString(),style: TextStyle(color: Colors.redAccent,fontSize: 20),))


            ])

            )
            

        ]),
        ListTile(leading: Icon(Icons.shop),title: Text('shop'),
        onTap: () {
        
        },),
         ListTile(leading: Icon(Icons.shop),title: Text('My orders'),
        onTap: () {
        
        },),
        ListTile(leading: Icon(Icons.shop),title: Text('Mange Products'),
        onTap: () {
         
        },)
      ],)
      
    );
  }
}