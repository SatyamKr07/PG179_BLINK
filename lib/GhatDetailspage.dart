import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps/Application.dart';
import 'package:maps/alleventsdisplay.dart';
import 'package:maps/locprovider.dart';
import 'package:maps/open_map.dart';
import 'package:maps/user_review.dart';
import 'package:maps/vendors.dart';
import './ghat_header.dart';
import './hostevent.dart';
import './NearbyPlaces.dart';
import 'package:provider/provider.dart';
import './photo_scroller.dart';
import './reviewdisplay.dart';

class GhatDetailsPage extends StatefulWidget {
  final String id;
  GhatDetailsPage(this.id);

  @override
  _GhatDetailsPageState createState() => _GhatDetailsPageState(id);
}

class _GhatDetailsPageState extends State<GhatDetailsPage> {
  final String id;
  int count = 0;
  bool isloading = true;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress = '';
  _GhatDetailsPageState(this.id);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((_) {
      setState(() {
        isloading = false;
      });
    });
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      // _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var placedata = Provider.of<Places>(context, listen: true);
    if (isloading && count == 0) {
      placedata.fetchDeatils(id);
      count = 1;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(AppTranslations.of(context).text("appbar_title")),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int val) {
              if (val == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventPage()));
              }
              if (val == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
              // if (val == 2) {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => NearbyPlaces()));
              // }
              // if (val == 3) {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Vendors()));
              // }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(AppTranslations.of(context).text("Organise_Event")),
                value: 0,
              ),
              PopupMenuItem(
                child: Text(AppTranslations.of(context).text("show_all")),
                value: 1,
              ),
              // PopupMenuItem(
              //   child:
              //       Text(AppTranslations.of(context).text("See Nearby places")),
              //   value: 2,
              // ),
              // PopupMenuItem(
              //   child: Text(AppTranslations.of(context).text("Local vendors")),
              //   value: 3,
              // )
            ],
          ),
        ],
      ),
      body: (isloading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MovieDetailHeader(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Storyline(),
                  ),
                  PhotoScroller(),
                  SizedBox(height: 20.0),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Container(
                                width: 160.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.mapMarked,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 5),
                                          child: Text(
                                            'Map \nNavigation',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => MapUtils.openMap(
                                      myLatitude: _currentPosition.latitude,
                                      myLongitude: _currentPosition.longitude,
                                      destinationLatitude: placedata.d.lat,
                                      destinationLongitude: placedata.d.long,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                width: 150.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.shopify,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, bottom: 5),
                                              child: Text(
                                                'Local \nVendors',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Get.to(Vendors());
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          width: 250.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.purple,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.placeOfWorship,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Search nearby Places',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Get.to(NearbyPlaces());
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 24.0),
                  //   child: RaisedButton(
                  //     onPressed: () {},
                  //     textColor: Colors.white,
                  //     color: Colors.blueAccent,
                  //     disabledColor: Colors.grey,
                  //     disabledTextColor: Colors.white,
                  //     highlightColor: Colors.orangeAccent,
                  //     elevation: 4.0,
                  //     child: Text('Take me there'),
                  //   ),
                  // ),
                  SizedBox(height: 20.0),
                  UserReview(id),
                ],
              ),
            ),
    );
  }
}
