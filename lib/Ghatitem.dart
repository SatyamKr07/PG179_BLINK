import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:provider/provider.dart';
import './Details.dart';
import './GhatDetailspage.dart';
import './locprovider.dart';

class Ghatitem extends StatelessWidget {
  final String id;
  final String name;
  final String rating;
  final String image;
  Ghatitem(this.name, this.image, this.rating, this.id);
  @override
  Widget build(BuildContext context) {
    final placedata = Provider.of<Places>(context, listen: false);
    return Container(
        child: Card(
            elevation: 10,
            child: GridTile(
                child: GestureDetector(
                  child: Image.network(
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${image}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo' !=
                            ''
                        ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${image}&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo'
                        : 'https://helpdeskgeek.com/wp-content/pictures/2020/06/no-internet.png',
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GhatDetailsPage(id)));
                  },
                ),
                footer: GridTileBar(
                  title: Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.black54,
                  leading: IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.redAccent,
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(AppTranslations.of(context)
                            .text("Youlikedthisghat")),
                        duration: Duration(seconds: 2),
                      ));
                    },
                  ),
                  trailing: Row(children: <Widget>[
                    Text(rating, style: TextStyle(fontSize: 18)),
                    Icon(Icons.stars)
                  ]),
                ))));
  }
}
