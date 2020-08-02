import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
import './Details.dart';
class RatingInformation extends StatelessWidget {
  RatingInformation();

  Widget _buildRatingBar(String rating) {
   
    var stars = <Widget>[];

    for (var i = 1; i <= 5; i++) {
      var color = i <= double.parse(rating) ? Colors.yellowAccent : Colors.black12;
      var star = Icon(
        Icons.star,
        color: color,
      );

      stars.add(star);
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
     var placedata=Provider.of<Places>(context,listen: false);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption.copyWith(color: Colors.black45);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          placedata.d.rating.toString(),
          style: textTheme.title.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.accentColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          AppTranslations.of(context).text("ratings"),
          style: ratingCaptionStyle,
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingBar(double.parse(placedata.d.rating.toString()).toString()),
       
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        numericRating,
        SizedBox(width: 16.0),
        starRating,
      ],
    );
  }
}