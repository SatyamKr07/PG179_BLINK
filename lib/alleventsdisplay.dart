import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:maps/Application.dart';
import 'package:maps/EventRegister.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static GoogleSignIn googleSignIn=GoogleSignIn();
  final user=googleSignIn.currentUser;
  final dio = new Dio(); // for http requests
  int test=0;
  Widget _appBarTitle = new Text('Search...');
  Icon _searchIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    final placedata=Provider.of<Places>(context,listen:true);
    print(user);
    
    return Scaffold(
      appBar: _buildBar(context),
      body: StreamBuilder(stream : Firestore.instance.collection('Events').snapshots(),builder:(context,snapshot)
      {
        if(!snapshot.hasData)
        return CircularProgressIndicator();
        else
        return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context,index) => builditem(snapshot.data.documents[index],placedata.user.userid)
         
        );}
        ));
  }
  Widget builditem(DocumentSnapshot d,String id)
  {
    var view=d['views'];
    List<dynamic> viewedby=d['viewedby'];
    if(!viewedby.contains(id))
    {
     d.reference.updateData({'views':++view});
     d.reference.updateData({'viewedby':FieldValue.arrayUnion([id])});
     
     test=1;
    }
  
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Organised By:${d['name']}",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(child: Text("4.3",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStar, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Icon(
                    FontAwesomeIcons.solidStarHalf, color: Colors.amber,
                    size: 15.0,),),
                  Container(child: Text("Contact number:${d['number']}",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                ],)),
        ),
        Container(child: Text("date:${d['Date']} time:${d['time']}",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
          SizedBox(height: 10,),
          RaisedButton(child: Text(AppTranslations.of(context).text("details")),color: Colors.blue,onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => EventRegister(d)));

          },)
      ],
    ),
                          ),
                        ),

                        Container(
                          width: 250,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: NetworkImage(
                                  "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${d['image']}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo"),
                            ),
                          ),),
                      ],)
                ),
              ),
            ),
        );
  }
         

 
  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
      }
    });
  }
}