import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import './Animation.dart';
class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
  EventPage();
}

class _EventPageState extends State<EventPage> {
  TextEditingController name=new TextEditingController();
  TextEditingController number=new TextEditingController();
  TextEditingController description=new TextEditingController();
  TextEditingController date=new TextEditingController();
  TextEditingController time=new TextEditingController();
  var photoreference;
  bool isloading=false;
  String ownerid;
  var ghatname;

  void postevent()
  {
    final postid=DateTime.now().toString();
    var docreference=Firestore.instance.collection('Events').document(postid);
    Firestore.instance.runTransaction((transaction) {
      setState(() {
        isloading=true;
             transaction.set(docreference, {
        'name':name.text.toString(),
        'number':number.text.toString(),
        'ownerid':ownerid,
        'description':description.text.toString(),
        'Date':date.text.toString(),
        'time':time.text.toString(),
        'postid':postid,
        'image':photoreference,
        'views':0,
        'GhatName':ghatname,
        'viewedby':[],
        'registered':[],

      });
      });
      var registereference=Firestore.instance.collection('Registeration').document(postid);
      Firestore.instance.runTransaction((transaction) {
        transaction.set(registereference, {
          'id':ownerid,
          'registered':[],

        });
        Firestore.instance.collection('ActivityFeed').document(ownerid).setData({
          'feeds':[]
        });



      });
      name.clear();
      number.clear();
      description.clear();
      date.clear();
      time.clear();
      print(isloading);
      setState(() {
        isloading=false;
      });

    });

  }
  
  @override
  Widget build(BuildContext context) {
    var placedata=Provider.of<Places>(context,listen: true);
    ownerid=placedata.user.userid;
    ghatname=placedata.d.name;
    photoreference=placedata.d.photos[0]['photo_reference'];
    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.of(context).text("Register_Event"))
      ),
      body:SingleChildScrollView(
      	child: Container(
	        child: Column(
	          children: <Widget>[
	            Container(
	              height: 400,
	              child: Stack(
	                children: <Widget>[
                    Image.network('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${placedata.d.photos[0]['photo_reference']}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo'),
	               Positioned(
	                    child: FadeAnimation(1.6, Container(
	                    margin: EdgeInsets.only(top: 50),
	                      child: Center(
	                        child: Text(AppTranslations.of(context).text("Register_Event"), style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	                      ),
	                    )),
	                  )
	                ],
	              ),
	            ),
	            Padding(
	              padding: EdgeInsets.all(20.0),
	              child: Column(
	                children: <Widget>[
	                  FadeAnimation(1.8, Container(
	                    padding: EdgeInsets.all(5),
	                    decoration: BoxDecoration(
	                      color: Colors.white,
	                      borderRadius: BorderRadius.circular(10),
	                      boxShadow: [
	                        BoxShadow(
	                          color: Color.fromRGBO(143, 148, 251, .2),
	                          blurRadius: 20.0,
	                          offset: Offset(0, 10)
	                        )
	                      ]
	                    ),
	                    child: Column(
	                      children: <Widget>[
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          decoration: BoxDecoration(
	                            border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                          ),
	                          child: TextField(
                              controller:number,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: AppTranslations.of(context).text("phone_number"),
                                
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextField(
                              controller: name,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: AppTranslations.of(context).text("name"),
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                           Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextField(
                              controller: date,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: AppTranslations.of(context).text("Date"),
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                           Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextField(
                              controller: time,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: AppTranslations.of(context).text("Time_of_the_event"),
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
                           Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextField(
                              controller: description,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: AppTranslations.of(context).text("Description"),
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        )
	                      ],
	                    ),
	                  )),
	                  SizedBox(height: 30,),
	                  FadeAnimation(2, Container(
	                    height: 50,
	                    decoration: BoxDecoration(
	                      borderRadius: BorderRadius.circular(10),
	                      gradient: LinearGradient(
	                        colors: [
	                          Color.fromRGBO(143, 148, 251, 1),
	                          Color.fromRGBO(143, 148, 251, .6),
	                        ]
	                      )
	                    ),
	                    child: Center(
	                      child: RaisedButton(child: isloading ? CircularProgressIndicator():Text(AppTranslations.of(context).text("PostEvent")),color: Color.fromRGBO(143, 148, 251, .6),onPressed: () {
                          postevent();

                        },),
	                    ),
	                  )),
	                 
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
      )
    );
    
  }
}