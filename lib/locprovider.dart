import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Userclass.dart';
import './Details.dart';

class Location {
  final lat;
  final long;
  final name;
  final rating;
  final imagelink;
  final id;
  Location(
      this.name, this.lat, this.long, this.rating, this.id, this.imagelink);
}

class Places extends ChangeNotifier {
  List<dynamic> _places = List<dynamic>();
  List<dynamic> _reviews = List<dynamic>();
  List<dynamic> _broad = List<dynamic>();
  User u;
  Details d;
  double _lat;
  double _long;
  Set<Marker> _markers = {};
  List<dynamic> get items {
    if (_places != null) return [..._places];
  }

  List<dynamic> get reviews {
    if (_reviews != null) return [..._reviews];
  }

  User get user {
    return u;
  }

  void setUser(String id) async {
    DocumentSnapshot ds =
        await Firestore.instance.collection("Users").document(id).get();
    u = User(ds['id'], ds['username'], ds['photo'], ds['points']);
    print(id);
    print(u.username);
  }

  Set<Marker> get markers {
    if (_markers != null) return _markers;
  }

  Future<void> fetch(double latitude, double longitude) async {
    print(latitude);
    _lat = latitude;
    _long = longitude;
    _markers.add(Marker(
        markerId: MarkerId('Your location'),
        position: LatLng(latitude, longitude),
        // position: LatLng(25.321684, 82.9872839),
        infoWindow: InfoWindow(title: 'Your location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose)));
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=15000&type=hindu_temple&keyword=ghats&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo';
    // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=25.321684,82.987289&radius=15000&type=hindu_temple&keyword=ghats&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo';
    final response = await http.get(url);
    final extracted = json.decode(response.body);
    print('yaaaaaa');
    List<dynamic> rithik = extracted['results'];
    rithik.forEach((data) {
      _places.add(Location(
          data['name'],
          data['geometry']['location']['lat'],
          data['geometry']['location']['lng'],
          data['rating'],
          data['place_id'],
          data['photos'][0]['photo_reference'] ?? ''));
      _markers.add(Marker(
          markerId: MarkerId(data['place_id']),
          position: LatLng(data['geometry']['location']['lat'],
              data['geometry']['location']['lng']),
          infoWindow: InfoWindow(title: data['name']),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet)));
    });
    _places.forEach((data) {
      print(data.imagelink.toString());
    });

    notifyListeners();
  }

  void clear() {
    _places.clear();
  }

  Future<void> fetchDeatils(String id) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&fields=geometry,name,photos,formatted_address,website,adr_address,opening_hours,review,price_level,rating,formatted_phone_number,international_phone_number&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo';
    final response = await http.get(url);
    final extracted = json.decode(response.body);
    final result = extracted['result'];
    print(result['reviews'][3]);

    d = Details(
        result['formatted_address'],
        result['reviews'],
        result['photos'],
        result['rating'],
        result['name'],
        result['geometry']['location']['lat'],
        result['geometry']['location']['lng']);
    DocumentSnapshot d1 =
        await Firestore.instance.collection('General').document(id).get();
    _reviews = d1['reviewedby'];

    notifyListeners();
  }
}
