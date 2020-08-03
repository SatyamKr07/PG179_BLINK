import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap({
    double myLatitude,
    double myLongitude,
    double destinationLatitude,
    double destinationLongitude,
  }) async {
    String googleUrl =
        // 'https://www.google.com/maps/dir/?api=1&origin=$myLatitude,$myLongitude&destination=$destinationLatitude,$destinationLongitude&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate';
        'https://www.google.com/maps/dir/?api=1&origin=$myLatitude,$myLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving&dir_action=navigate';

    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
