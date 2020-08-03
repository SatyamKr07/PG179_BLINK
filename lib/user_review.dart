

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/Userclass.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import 'package:get/get.dart';
import 'write_review.dart';

class UserReview extends StatefulWidget {
  final String id;
  UserReview(this.id);
  @override
  _UserReviewState createState() => _UserReviewState(id);
}

class _UserReviewState extends State<UserReview> {
  bool selected1=false;
  bool selected2=false;
  var placedata;
  final String ghatid;
  bool selected3=false;
  bool selected4=false;
  bool selected5=false;
  bool selected6=false;
  bool selected7=false;
  List<bool> selected=[];
  bool selected8=false;
  bool selected9=false;
  bool selected10=false;
  bool selected11=false;
  bool selected12=false;
  bool selected13=false;
  bool selected14=false;
  bool selected15=false;
  bool selected16=false;
  bool selected17=false;
  bool selected18=false;
  String answer1="Dont know";String answer2="Dont know";String answer3="Dont know";
  var myFeedbackText = "COULD BE BETTER";
  var sliderValue = 0.0;
  int yes1=0;int no1=0;int dontknow1=0;
  int yes2=0;int no2=0;int dontknow2=0;
  int yes3=0;int no3=0;int dontknow3=0;
  double avgrating=0;
  String id;
  int c=0;
  List<dynamic> reviews;
  _UserReviewState(this.ghatid);
  IconData myFeedback = FontAwesomeIcons.sadTear;
  Color myFeedbackColor = Colors.red;
  @override
  Widget build(BuildContext context) {
    c++;
    for(int i=0;i<1000;i++)
    selected.add(false);
     placedata=Provider.of<Places>(context,listen:false);
     id=placedata.u.userid;
     reviews=placedata.reviews;
     if(c==1)
     {
     for(int i=0;i<reviews.length;i++)
     {
       if(reviews[i]['dustbin']=="Yes")
       yes1++;
       else if(reviews[i]['dustbin']=="No")
       no1++;
       else
       dontknow1++;

       if(reviews[i]['Toilet']=="Yes")
       yes2++;
       else if(reviews[i]['Toilet']=="No")
       no2++;
       else
       dontknow2++;

       if(reviews[i]['Cremation']=="Yes")
       yes3++;
       else if(reviews[i]['Cremation']=="No")
       no3++;
       else
       dontknow3++;

       avgrating=avgrating+double.parse(reviews[i]['rating']);
       
       }
     }
       if(c==1)
       avgrating=(reviews.length != 0) ? avgrating/reviews.length:avgrating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 12),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                color: Colors.grey[300]),
            child: Container(
        color: Color(0xffE5E5E5),
        child: Column(
          children: <Widget>[
            Container(child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(child: Text("1. On a scale of 1 to 5, how do you rate the cleanliness of the ghat?",
                style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),)),
            ),),
            SizedBox(height:20.0),
            Container(
              child: Align(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                      width: 350.0,
                      height: 350.0,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Text(myFeedbackText,
                            style: TextStyle(color: Colors.black, fontSize: 22.0),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Icon(
                            myFeedback, color: myFeedbackColor, size: 100.0,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Slider(
                              min: 0.0,
                              max: 5.0,
                              divisions: 5,
                              value: sliderValue,
                              activeColor: Color(0xffff520d),
                              inactiveColor: Colors.blueGrey,
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue = newValue;
                                  if (sliderValue >= 0.0 && sliderValue <= 1.0) {
                                    myFeedback = FontAwesomeIcons.sadTear;
                                    myFeedbackColor = Colors.red;
                                    myFeedbackText = "COULD BE BETTER";
                                  }
                                  if (sliderValue >= 1.1 && sliderValue <= 2.0) {
                                    myFeedback = FontAwesomeIcons.frown;
                                    myFeedbackColor = Colors.yellow;
                                    myFeedbackText = "BELOW AVERAGE";
                                  }
                                  if (sliderValue >= 2.1 && sliderValue <= 3.0) {
                                    myFeedback = FontAwesomeIcons.meh;
                                    myFeedbackColor = Colors.amber;
                                    myFeedbackText = "NORMAL";
                                  }
                                  if (sliderValue >= 3.1 && sliderValue <= 4.0) {
                                    myFeedback = FontAwesomeIcons.smile;
                                    myFeedbackColor = Colors.green;
                                    myFeedbackText = "GOOD";
                                  }
                                  if (sliderValue >= 4.1 && sliderValue <= 5.0) {
                                    myFeedback = FontAwesomeIcons.laugh;
                                    myFeedbackColor = Color(0xffff520d);
                                    myFeedbackText = "EXCELLENT";
                                  }
                                });
                              },
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(child: Text("Your Rating: $sliderValue\n (Average rating : $avgrating)",
                            style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),)),
                        ),
                        
                      ],)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Get.to(WriteReview(ghatid));
          },
          child: Text(
            " Click to Write your review",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),

          // color: Colors.blue[200],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Does this ghat has :",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        doesThisGhatHas("1. Dustbin"),
        doesThisGhatHas2("2. Toilet"),
        doesThisGhatHas3("3. Cremation"),
        doesThisGhatHas4("4. Women and child care facilities"),
        doesThisGhatHas5("5. Seperate washrooms"),
        doesThisGhatHas6("6. CCTVs"),
        SizedBox(height: 20),
        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Align(
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: Color(0xffff520d),
                              child: Text('Submit',
                                style: TextStyle(color: Color(0xffffffff)),),
                              onPressed: () async{
                                DocumentSnapshot d1=await Firestore.instance.collection('General').document(ghatid).get();
                                if(d1.exists)
                                {
                                  d1.reference.updateData({'reviewedby': FieldValue.arrayUnion([{
                                  "id":placedata.u.userid, 
                                  "ghatid":ghatid,
                                  "dustbin":answer1,
                                  "Toilet":answer2,
                                  "Cremation":answer3,
                                  "rating":sliderValue.toString()
                                  }])});
                                }
                                else
                                {
                                Firestore.instance.collection('General').document(ghatid).setData({
                                  'reviewedby':FieldValue.arrayUnion([{
                                  "id":placedata.u.userid, 
                                  "ghatid":ghatid,
                                  "dustbin":answer1,
                                  "Toilet":answer2,
                                  "Cremation":answer3,
                                  "rating":sliderValue.toString()
                                }])
                                });
                                }
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                  title: Text('Thank you'),
                                  content: Text('Your review is of great importance!'),
                                    )
    );

                              },
                            ),
                          )),
                        ),
      othersReview()
      ],
    );
  }

  othersReview() {
    
    return 
      StreamBuilder(stream: Firestore.instance.collection('BroadGeneral').where('ghatid',isEqualTo: ghatid).snapshots(),
     builder: (context,snapshot) {
       if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator(),);
       }
        else
        {
          if(snapshot.data.documents.length==0)
          return Container();
            return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.documents[index]['photo']),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          snapshot.data.documents[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            RatingBar(
                              itemSize: 15,
                              initialRating: double.parse(snapshot.data.documents[index]['rating']),
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              // onRatingUpdate: (rating) {
                              //   print(rating);
                              // },
                            ),
                            Text(
                              "22 july, 2020 ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "title: Review ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    snapshot.data.documents[index]['review'],
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    snapshot.data.documents[index]['image'],

                    fit: BoxFit.fill,
                  ),
                
                  
                ),
                SizedBox(height: 3,),
                Row(children:<Widget>[
                  IconButton(icon: (selected[index] || snapshot.data.documents[index]['upvotes'].contains(placedata.u.userid)) ? Icon(Icons.favorite) : Icon(Icons.favorite_border), onPressed: () async{
                    DocumentSnapshot d=await Firestore.instance.collection('BroadGeneral').document(snapshot.data.documents[index]['postid']).get();
                    if(selected[index])
                    {
                       setState(() {
                         selected[index]=false;
                         d.reference.updateData({'upvotes':FieldValue.arrayRemove([
                          placedata.u.userid
                         ])});
                    });
                    }
    
                    else
                    {
                      setState(() {
                         selected[index]=true;
                         d.reference.updateData({'upvotes':FieldValue.arrayUnion([
                          placedata.u.userid
                         ])});
                       });
                    }
              

                  }),
                  SizedBox(width: 2,),
                  Text('Upvotes(${snapshot.data.documents[index]['upvotes'].length})')
                ])
              ],
            )
          );
        });
        }
     }) ; 
    
    
        // return ListTile(
        //   leading: CircleAvatar(
        //     backgroundImage: NetworkImage(""),
        //   ),
        //   title: Text('UserName'),
        //   subtitle: Text("Heading"),
        //   // trailing: Icon(Icons.keyboard_arrow_right),
        //   // onTap: () {
        //   //   print('horse');
        //   // },
        //   // selected: true,
        // );

        
  }

  doesThisGhatHas(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected1) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           answer1="Yes";
           yes1++;
           selected1=true;
           selected2 = !true;
           selected3 = !true;
        });
      },
      child: Text("YES($yes1)"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected2) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
          answer1="No";
          no1++;
           selected2=true;
           selected1 = !true;
           selected3 = !true;
        });
      },
      child: Text("NO($no1)"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected3) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected3=true;
           dontknow1++;
           selected2 = false;
           selected1 = false;
        });
      },
      child: Text("Dont Know($dontknow1)"),
      
    ),
  ),
            ],
          ),
        ],
      ),
    );
  }
  doesThisGhatHas2(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected4) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           answer2="Yes";
           yes2++;
           selected4=true;
           selected5 = !true;
           selected6 = !true;
        });
      },
      child: Text("YES($yes2)"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected5) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           answer2="No";
           no2++;
           selected5=true;
           selected4 = !true;
           selected6 = !true;
        });
      },
      child: Text("NO($no2)"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected6) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected6=true;
           dontknow2++;
           selected5 = false;
           selected4 = false;
        });
      },
      child: Text("Dont Know($dontknow2)"),
      
    ),
  ),
            ],
          ),
        ],
      ),
    );
  }
  doesThisGhatHas3(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected7) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           answer3="Yes";
           yes3++;
           selected7=true;
           selected8 = !true;
           selected9 = !true;
        });
      },
      child: Text("YES($yes3)"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected8) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           answer3="No";
           no3++;
           selected8=true;
           selected7 = !true;
           selected9 = !true;
        });
      },
      child: Text("NO($no3)"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected9) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected9=true;
           dontknow3++;
           selected8 = false;
           selected7 = false;
        });
      },
      child: Text("Dont Know($dontknow3)"),
      
    ),
  ),
            ],
          ),
        ],
      ),
    );
  }
  doesThisGhatHas4(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected10) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected10=true;
           selected11 = !true;
           selected12 = !true;
        });
      },
      child: Text("YES"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected11) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected11=true;
           selected10 = !true;
           selected12 = !true;
        });
      },
      child: Text("NO"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected12) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected12=true;
           selected11= false;
           selected10 = false;
        });
      },
      child: Text("Dont Know"),
      
    ),
  ),
            ],
          ),
        ],
      ),
    );
  }
   doesThisGhatHas5(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected13) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected13=true;
           selected14 = !true;
           selected15 = !true;
        });
      },
      child: Text("YES"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected14) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected14=true;
           selected13 = !true;
           selected15 = !true;
        });
      },
      child: Text("NO"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected15) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected15=true;
           selected14= false;
           selected13 = false;
        });
      },
      child: Text("Dont Know"),
      
    ),
  ),
            ],
          ),
        ],
      ),
    );
  }
   doesThisGhatHas6(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected16) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected16=true;
           selected17 = !true;
           selected18 = !true;
        });
      },
      child: Text("YES"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected17) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected17=true;
           selected16 = !true;
           selected18 = !true;
        });
      },
      child: Text("NO"),
      
    ),
  ),
              Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected18) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
        setState(() {
           selected18=true;
           selected17= false;
           selected16 = false;
        });
      },
      child: Text("Dont Know"),
      
    ),
  ),
            ],
          ),
        ],
      ),
    );
  }
}
 



options(String option,bool selected) {

  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: (!selected) ? Border.all(width: 1.0, color: Colors.grey) :Border.all(width: 3.0, color: Colors.blueAccent),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {
          
          },
      child: Text(option),
      
    ),
  );
}
