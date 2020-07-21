import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:maps/alleventsdisplay.dart';
import 'package:maps/locprovider.dart';
import 'package:maps/user_review.dart';
import './ghat_header.dart';
import './hostevent.dart';
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
  _GhatDetailsPageState(this.id);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((_) {
      setState(() {
        isloading = false;
      });
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
              if (val == 2) {}
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
              PopupMenuItem(
                child: Text(AppTranslations.of(context).text("Report")),
                value: 2,
              ),
            ],
          ),
        ],
      ),
      body: (isloading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  MovieDetailHeader(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Storyline(),
                  ),
                  PhotoScroller(),
                  SizedBox(height: 20.0),
                  UserReview(),
                ],
              ),
            ),
    );
  }
}
