import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps/locprovider.dart';
import 'package:provider/provider.dart';

class AddNewPlace extends StatefulWidget {
  @override
  _AddNewPlaceState createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  File _image;
  var placedata;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress = '';
  TextEditingController review = new TextEditingController();
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  _getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name},${place.subLocality},${place.locality},${place.postalCode},${place.administrativeArea},${place.country}\n(${place.position})";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    placedata = Provider.of<Places>(context, listen: false);
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue[50],
        // ),
        body: Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 8),
      child: ListView(
        children: <Widget>[
          Wrap(
            children: [
              IconButton(
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          Text(
            "Found a place which is not there on the app?",
            style: TextStyle(fontSize: 28),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Text(
              "Add details below!",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: _image == null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[50],
                      ),
                      height: 300,
                      // color: Colors.grey,
                      child: Center(
                        child: new Text(
                          'No Image Selected ',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    )
                  : new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.blue[50],
                      ),
                      // width: 200,
                      // height: 200,
                      child: Image.file(_image, fit: BoxFit.contain))
              //Image.file(imageFile,height: 200,width: 200,),
              ),
          Container(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add image (mandatory)',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: 3),
                IconButton(
                  onPressed: () async {
                    await getImageFromCamera().then((value) {
                      _image = _image;
                    });
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          FlatButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: () async {
                await _getCurrentLocation();
              },
              label: Text('Click to get current location'),
              color: Colors.blue[50]),
          Container(
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Location: $_currentAddress"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 24),
            child: TextFormField(
              controller: review,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Add description",
                helperMaxLines: null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24),
            child: FlatButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        title: Text('Processing'),
                        content: CircularProgressIndicator()));
                String fileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                StorageReference refernce =
                    FirebaseStorage.instance.ref().child(fileName);
                StorageUploadTask uploasTask = refernce.putFile(_image);
                StorageTaskSnapshot storageTaskSnapshot =
                    await uploasTask.onComplete;
                storageTaskSnapshot.ref.getDownloadURL().then((url) async {
                  String postid = DateTime.now().toString();
                  Firestore.instance
                      .collection('AddPlaces')
                      .document(postid)
                      .setData({
                    "id": placedata.u.userid,
                    "image": url,
                    "name": placedata.u.username,
                    "photo": placedata.u.photourl,
                    "postid": postid,
                    "review": review.text,
                    "location": _currentAddress,
                    "date": DateTime.now(),
                    "reviewed": 0,
                    "longlat": _currentPosition.toString()
                  });

                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          title: Text('Thank You'),
                          content: Text(
                              'We hope that your data gets verified soon..and guess what add 20 points to your score:)')));
                });
              },
              child: Text("Post for verification",
                  style: TextStyle(color: Colors.white)),
              color: Colors.blue,
            ),
          )
        ],
      ),
    ));
  }
}
