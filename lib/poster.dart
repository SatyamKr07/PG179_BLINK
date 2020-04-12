import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  Poster(
    this.posterUrl, {
    this.height = 100.0,
  });

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: Image.network(
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${posterUrl}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo',
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}