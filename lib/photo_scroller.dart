import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import './locprovider.dart';
import 'package:provider/provider.dart';

class PhotoScroller extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    var placedata=Provider.of<Places>(context,listen:false);
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            AppTranslations.of(context).text("photos"),
            style: TextStyle(fontSize: 18.0,color: Colors.black54),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(100.0),
          child: ListView.builder(
            itemCount: placedata.d.photos.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder:(context,index) => Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(
          (placedata.d.photos != []) ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${placedata.d.photos[index]['photo_reference']}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo':'',
          width: 160.0,
          height: 120.0,
          fit: BoxFit.cover,
        ),
      ),
    ),
          ),
        ),
      ],
    );
  }
}