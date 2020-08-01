import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:maps/MyPlaces.dart';
import 'package:maps/locprovider.dart';
import 'package:provider/provider.dart';

class NearbyPlaces extends StatefulWidget {
  @override
  _NearbyPlacesState createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  final placeselected = TextEditingController();
  var placedata;
  List<String> places = [
    'accounting',
    'airport',
    'amusement_park',
    'aquarium',
    'art_gallery',
    'atm',
    'bakery',
    'bank',
    'bar',
    'beauty_salon',
    'bicycle_store',
    'book_store',
    'bowling_alley',
    'bus_station',
    'cafe',
    'campground',
    'car_dealer',
    'car_rental',
    'car_repair',
    'car_wash',
    'casino',
    'cemetery',
    'church',
    'city_hall',
    'clothing_store',
    'convenience_store',
    'courthouse',
    'dentist',
    'department_store',
    'doctor',
    'drugstore',
    'electrician',
    'electronics_store',
    'embassy',
    'fire_station',
    'florist',
    'funeral_home',
    'furniture_store',
    'gas_station',
    'gym',
    'hair_care',
    'hardware_store',
    'hindu_temple',
    'home_goods_store',
    'hospital',
    'insurance_agency',
    'jewelry_store',
    'laundry',
    'lawyer',
    'library'
        'light_rail_station',
    'liquor_store',
    'local_government_office',
    'locksmith',
    'lodging',
    'meal_delivery',
    'meal_takeaway',
    'mosque',
    'movie_rental',
    'movie_theater',
    'moving_company',
    'museum',
    'night_club',
    'painter',
    'park',
    'parking',
    'pet_store',
    'pharmacy',
    'physiotherapist',
    'plumber',
    'police',
    'post_office',
    'primary_school',
    'real_estate_agency',
    'restaurant',
    'roofing_contractor'
        'rv_park',
    'school',
    'secondary_school',
    'shoe_store',
    'shopping_mall',
    'spa',
    'stadium',
    'storage',
    'store',
    'subway_station',
    'supermarket',
    'synagogue',
    'taxi_stand',
    'tourist_attraction',
    'train_station',
    'transit_station',
    'travel_agency',
    'university',
    'veterinary_care'
        'zoo'
  ];
  String place;
  @override
  Widget build(BuildContext context) {
    placedata = Provider.of<Places>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search nearby places'),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 100,
        ),
        DropDownField(
          controller: placeselected,
          hintText: 'Select any place',
          enabled: true,
          items: places,
          onValueChanged: (value) {
            setState(() {
              place = value;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Color(0xffff520d),
                child: Text(
                  'Search...',
                  style: TextStyle(color: Color(0xffffffff)),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyPlaces(
                              place, placedata.d.lat, placedata.d.long)));
                }),
          )),
        )
      ]),
    );
  }
}
