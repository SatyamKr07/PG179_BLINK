import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GovernmentDetails extends StatefulWidget {
  final DocumentSnapshot d;
  GovernmentDetails(this.d);
  @override
  _GovernmentDetailsState createState() => _GovernmentDetailsState(d);
}

class _GovernmentDetailsState extends State<GovernmentDetails> {
  final DocumentSnapshot d;
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingController2 = new TextEditingController();
  _GovernmentDetailsState(this.d);
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 2,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        // "\$20",
        "\$" + d['budget'].toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Container(
          width: 140.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          d['title'],
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Let us join hands",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(d['image']),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
    final bottomContentText = Text(
      d['description'],
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Details'),
                    content: Container(
                        height: 300,
                        child: ListView(children: <Widget>[
                          Text('Please enter your phone number'),
                          TextField(
                            controller: textEditingController,
                            decoration:
                                InputDecoration(hintText: "Your phone number"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Text(
                                  'Please specify how are you going to contribute toward this project\n1.Raising funds\n2.Work on field\n3.advertise about this project\n4.any other valid reason')),
                          TextField(
                            controller: textEditingController2,
                            decoration:
                                InputDecoration(hintText: "Description"),
                          )
                        ])),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('SUBMIT'),
                        onPressed: () {
                          AlertDialog(
                            title: Text('Thank you very much'),
                            content: Text(
                                'Your response has been recorded,A government official will soon contact you'),
                          );
                        },
                      )
                    ],
                  );
                })
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
              Text("Join the project", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(title: Text('Brief Description')),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[topContent, bottomContent],
        )));
  }
}
