import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps/Application.dart';
import './locprovider.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as http;
import 'package:permission/permission.dart';
class LocationInput extends StatefulWidget {
  static const routeName='/locationinput';
  final double lat;
  final double long;
  LocationInput(this.lat,this.long);
  @override
  _LocationInputState createState() => _LocationInputState(this.lat,this.long);
}

class _LocationInputState extends State<LocationInput> {
  String image;
  int count = 0;
  final double lat,long;
  _LocationInputState(this.lat,this.long);
  List<int> views=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  
  static var geolocator = Geolocator();
  
static var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
  final Set<Polyline> polyline={};
  Set<Circle> circles = Set.from([Circle(
    circleId: CircleId('circle1'),
    fillColor: Colors.black38,
    center: LatLng(21,83),
    radius: 4000,
)]);
  List<LatLng> routecord=[];
  GoogleMapPolyline googleMapPolyline=new GoogleMapPolyline(apiKey: 'AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo');
  var locdata;
  Completer<GoogleMapController> _controller=Completer();
  GoogleMapController _controller1;
  void getpoints(double latitude,double longitude) async
  { var permission=await Permission.getPermissionsStatus([PermissionName.Location]);
  if(permission[0].permissionStatus == PermissionStatus.notAgain)
  {
    var ask=await Permission.requestPermissions([PermissionName.Location]);
  }
  else
  {
    routecord=await googleMapPolyline.getCoordinatesWithLocation(origin:LatLng(lat,long) , destination: LatLng(latitude,longitude), mode: RouteMode.driving);
     polyline.clear();
      polyline.add(Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points:routecord,
        width:4,
        color:Colors.blue,
        startCap: Cap.roundCap,
        endCap:Cap.buttCap
      ));
       final GoogleMapController controller=await _controller.future;
   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 15,tilt: 50,bearing: 45)));

    setState(() {
      print(routecord);
      
    });
 
     
  }
   

  }
 void goto(double lat,double long) async {
   final GoogleMapController controller=await _controller.future;
   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 21,tilt: 50,bearing: 45)));

 } 

  
 
  @override
  void initState()
  {
    super.initState();

  }

  Future<void> getlocation() async
  {
    locdata=await http.Location().getLocation();
    print('here i am');
    print(locdata.lat);
    
  }
  @override
  Widget build(BuildContext context) {
    print('yaha pe pahucha');
      final placedata=Provider.of<Places>(context,listen: true);
    return Scaffold(appBar: AppBar(title: Text('Map overview'),),body:  Stack(children:<Widget>[GoogleMap(
      onMapCreated: onMapcreated,
      polylines:polyline,
      initialCameraPosition: CameraPosition(target:LatLng(lat,long),zoom: 14.0),
      mapType: MapType.normal,
      circles: circles,
      markers: placedata.markers,
      

    ),buildContainer(placedata.items)]));
  }
  void onMapcreated(GoogleMapController controller)
  {print('Onmaopcrtagbudj');
    _controller.complete(controller);
    setState(() {
      _controller1=controller;
     
      
    });

  }
  Widget buildContainer(List<dynamic> list)
  {
    return Align(
      alignment: Alignment.bottomLeft,
      child:Container(margin: EdgeInsets.symmetric(vertical:20),
      height: 150,
      width:double.infinity,
      child:ListView.builder(scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context,index) {
        views[index]++;
        print(views[index]);
        print('ye wal bada $index');
        
        return Row(children:<Widget>[SizedBox(width:10.0),GestureDetector(onTap: () => goto(list[index].lat,list[index].long),child: Container(child:new FittedBox(
          child:Material(color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor:Colors.blue,
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(width:150,
            height: 150,
            child:ClipRRect(borderRadius: new BorderRadius.circular(24),
            child:Image(fit: BoxFit.cover,
            image:NetworkImage('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${list[index].imagelink}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo')))),
            myDetails(list[index].name,list[index].rating.toString(),list[index].lat,list[index].long),
          ],)
          )
        ),))]);
      },)
      )
      
    );
  }
Widget myDetails(String name,String rating,double lat,double long)
{
  return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    Padding(padding: const EdgeInsets.only(left: 8.0),
    child:Container(child: Text(name,style: TextStyle(color: Colors.black54,
    fontSize: 24,
    fontWeight: FontWeight.bold),),))
    ,
    SizedBox(height:5.0),
    Container(child: Row(
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      children:<Widget>[Container(
        child:Text(rating.toString(),style:TextStyle(color:Colors.black54
        ,fontSize: 18.0),
        )),
         Container(child:Icon(Icons.stars,color:Colors.amber,size:14.0)),
         Container(child: Text('967',style:TextStyle(color: Colors.black54,fontSize: 18.0)))
      ]
    ),),
    SizedBox(height: 5.0,),
    Text(AppTranslations.of(context).text("timings"),style: TextStyle(color: Colors.black54,
    fontSize: 18.0,fontWeight: FontWeight.bold),),
    FlatButton(child: Text(AppTranslations.of(context).text("Gettheroute"),style: TextStyle(color: Colors.blueAccent,fontSize: 18.0,fontWeight:FontWeight.normal)),onPressed: () => getpoints(lat, long),)
   
    
  ],);
}

  }
