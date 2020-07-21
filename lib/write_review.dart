import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  File _image;

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
                  onPressed: () {
                    debugPrint('I am Awesome');
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
                    "Rate Cleaniness of ghat",
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
                      onRatingUpdate: (rating) {
                        print(rating);
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                : new Image.file(_image),
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
                IconButton(
                  onPressed: () async {
                    await getImageFromGallery().then((value) {
                      _image = _image;
                    });
                  },
                  icon: Icon(
                    Icons.photo_library,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
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
              },
            ),
          ),
        ),
      ],
    );
  }
}
