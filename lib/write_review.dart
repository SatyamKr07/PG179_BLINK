import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps/locprovider.dart';
import 'package:provider/provider.dart';

class WriteReview extends StatefulWidget {
  final String ghatid;
  WriteReview(this.ghatid);
  @override
  _WriteReviewState createState() => _WriteReviewState(ghatid);
}

class _WriteReviewState extends State<WriteReview> {
  File _image;
  double rating;
  String ghatid;
  var placedata;
  String review;
  _WriteReviewState(this.ghatid);

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    placedata = Provider.of<Places>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // SizedBox(
          //   height: height / 25,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (_image != null) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                              title: Text('Processing'),
                              content: CircularProgressIndicator()));
                      String fileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      StorageReference refernce =
                          FirebaseStorage.instance.ref().child(fileName);
                      StorageUploadTask uploasTask = refernce.putFile(_image);
                      StorageTaskSnapshot storageTaskSnapshot =
                          await uploasTask.onComplete;
                      storageTaskSnapshot.ref
                          .getDownloadURL()
                          .then((url) async {
                        String postid = DateTime.now().toString();
                        Firestore.instance
                            .collection('BroadGeneral')
                            .document(postid)
                            .setData({
                          "id": placedata.u.userid,
                          "ghatid": ghatid,
                          "image": url,
                          "name": placedata.u.username,
                          "photo": placedata.u.photourl,
                          "postid": postid,
                          "latitude": placedata.d.lat,
                          "longitude": placedata.d.long,
                          "date": DateTime.now(),
                          "review": review,
                          "rating": rating.toString(),
                          "upvotes": []
                        });

                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                title: Text('Thank You'),
                                content: Text(
                                    'Your review has been successfully recorded')));
                      });
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.black,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  elevation: 4.0,
                  child: Text('Post'),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[300]),
              child: Column(
                children: <Widget>[
                  Text(
                    "Overall rating of ghat",
                    style: TextStyle(fontSize: 16),
                  ),
                  Center(
                    child: RatingBar(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (ratin) {
                        rating = ratin;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          writeReviewTemplate(),
          SizedBox(
            height: height / 40,
          ),

          // SizedBox(
          //   height: 20,
          // ),
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: _image == null
                  ? Center(
                      child: new Text(
                        'No Image Selected ',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  : new Container(
                      width: 200,
                      height: 200,
                      child: Image.file(_image, fit: BoxFit.cover))
              //Image.file(imageFile,height: 200,width: 200,),
              ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Add image (optional)',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 3),
                IconButton(
                  onPressed: () async {
                    await getImageFromCamera().then((value) {
                      _image = _image;
                    });
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                // IconButton(
                //   onPressed: () async {
                //     await getImageFromGallery().then((value) {
                //       _image = _image;
                //     });
                //   },
                //   icon: Icon(
                //     Icons.photo_library,
                //     color: Colors.black,
                //     size: 40,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  writeReviewTemplate() {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 150,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 350,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: TextFormField(
              minLines: 4,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autofocus: false,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
//                      validator: (String value){
//                        if(value.isEmpty)
//                          return "Enter the question please!";
//
//                      },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Write your review here...",
                hintStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
              onChanged: (val) {
                // widget.onChanged(val);
                review = val;
              },
            ),
          ),
        ),
      ],
    );
  }
}
