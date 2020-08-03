import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps/Ghatitem.dart';
import 'package:maps/locprovider.dart';
import 'package:provider/provider.dart';

class SeeGhats extends StatefulWidget {
  final String s;
  SeeGhats(this.s);
  @override
  _SeeGhatsState createState() => _SeeGhatsState(s);
}

class _SeeGhatsState extends State<SeeGhats> {
  final String s;
  double lat, long;
  int count = 0;
  _SeeGhatsState(this.s);
  void location(String s) async {
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(s);
    long = placemark[0].toJson()['position']['longitude'];
    lat = placemark[0].toJson()['position']['latitude'];
    setState(() {});
  }

  void initState() {
    super.initState();
    location(s);
  }

  @override
  Widget build(BuildContext context) {
    final placedata = Provider.of<Places>(context, listen: true);
    if (lat != null && count == 0) {
      placedata.fetch2(lat, long);
      count = 1;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Ghats near  " + s),
        ),
        body: (lat != null && placedata?.places2?.length != 0)
            ? GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: placedata?.places2?.length,
                itemBuilder: (ctx, i) => Ghatitem(
                    placedata.places2[i]?.name ?? "",
                    placedata.places2[i]?.imagelink,
                    placedata.places2[i]?.rating.toString(),
                    placedata.places2[i]?.id),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
