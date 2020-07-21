import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'write_review.dart';

class UserReview extends StatefulWidget {
  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 12),
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
        FlatButton(
          onPressed: () {
            Get.to(WriteReview());
          },
          child: Text(
            " Click to Write your review",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),

          // color: Colors.blue[200],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Does this ghat has :",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        doesThisGhatHas("1. Dustbin"),
        doesThisGhatHas("2. Toilet"),
        SizedBox(height: 20),
        othersReview(),
      ],
    );
  }

  othersReview() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(""),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Satyam Kumar",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            RatingBar(
                              itemSize: 15,
                              initialRating: 2,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              // onRatingUpdate: (rating) {
                              //   print(rating);
                              // },
                            ),
                            Text(
                              "22 july, 2020 ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "title: Good ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Ghat is quite clean",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "https://www.tripsavvy.com/thmb/RILVRIzuovXkCqf3ueEQQfDY8o0=/2124x1412/filters:fill(auto,1)/GettyImages-128253674-592156025f9b58f4c0d79bfd.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        }
        // return ListTile(
        //   leading: CircleAvatar(
        //     backgroundImage: NetworkImage(""),
        //   ),
        //   title: Text('UserName'),
        //   subtitle: Text("Heading"),
        //   // trailing: Icon(Icons.keyboard_arrow_right),
        //   // onTap: () {
        //   //   print('horse');
        //   // },
        //   // selected: true,
        // );

        );
  }

  doesThisGhatHas(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              options("yes"),
              options("No"),
              options("Not sure"),
            ],
          ),
        ],
      ),
    );
  }
}

options(String option) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    decoration: BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.grey),
      borderRadius: BorderRadius.all(
          Radius.circular(100.0) //                 <--- border radius here
          ),
    ),
    child: GestureDetector(
      onTap: () {},
      child: Text(option),
      // color: Colors.blue[200],
    ),
  );
}
