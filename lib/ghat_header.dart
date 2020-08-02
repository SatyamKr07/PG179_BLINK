import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './locprovider.dart';
import './arc_banner.dart';
import './poster.dart';
import './rating_info.dart';

class MovieDetailHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var placedata = Provider.of<Places>(context, listen: false);

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          placedata.d.name,
          style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
        SizedBox(height: 8.0),
        RatingInformation(),
        SizedBox(height: 12.0),
        Text('Open:${placedata.d.opennow}'),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(
            placedata.d.photos != []
                ? placedata.d.photos[0]['photo_reference']
                : '',
            // "https://thumbs.dreamstime.com/b/no-image-available-icon-vector-illustration-flat-design-140476186.jpg"
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Poster(
                // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
                (placedata.d.photos != [])
                    ? placedata.d.photos[0]['photo_reference'] != ''
                        ? placedata.d.photos[0]['photo_reference']
                        : "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482930.jpg"
                    : "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482930.jpg",
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
