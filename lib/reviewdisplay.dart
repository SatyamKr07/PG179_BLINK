import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import './locprovider.dart';
import 'package:provider/provider.dart';

class Storyline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placedata = Provider.of<Places>(context, listen: false);
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (placedata.d.reviews != null)
            ? Text(
                '${placedata.d.reviews[0]['author_name']}    ${placedata.d.reviews[0]['relative_time_description']}',
                style: textTheme.subhead.copyWith(fontSize: 18.0),
              )
            : Container(),
        SizedBox(height: 8.0),
        Text(
          (placedata.d.reviews != null)
              ? placedata.d.reviews[0]['text']
              : 'no review available',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 16.0,
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppTranslations.of(context).text("Seemorereviews"),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
              color: theme.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}
