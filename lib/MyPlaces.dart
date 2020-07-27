import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class MyPlaces extends StatefulWidget {
  final String type;
  final double lat;
  final double long;
  MyPlaces(this.type,this.lat,this.long);
  @override
  _MyPlacesState createState() => _MyPlacesState(type,lat,long);
}

class _MyPlacesState extends State<MyPlaces> {
  final String type;
  final double lat;
  final double long;
  List<dynamic> result;
  bool isloading = true;
  _MyPlacesState(this.type,this.lat,this.long);
  void search() async
  {
      final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=10000&type=$type&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo';
    final response=await http.get(url);
    final extracted=json.decode(response.body); 
    result = extracted['results'];
    print(result[0]['name']);
    setState(() {
      isloading=false;
      print(result[0]['photos'][0]['photo_reference']);
    });
  }
  @override
  void initState() 
  {
    super.initState();
    search(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Results'),),
      body:(isloading) ? CircularProgressIndicator() :
        ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),  
        shrinkWrap: true,
        itemCount: result.length,
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
                      backgroundImage: NetworkImage(result[index]['icon']),
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
                          result[index]['name'],
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
                              initialRating: result[index]['rating'].toDouble(),
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
                    result[index]['vicinity'],
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    snapshot.data.documents[index]['review'],
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ),*/
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                (result[index]['photos'] != null) ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result[index]['photos'][0]['photo_reference']}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo' :
                "",

                    fit: BoxFit.fill,
                  ),
                
                  
                ),
                SizedBox(height: 3,),
              ],
            )
          );
        })

      
      


      
    );
  }
}