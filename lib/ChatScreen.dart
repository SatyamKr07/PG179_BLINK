import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps/Application.dart';
import 'package:maps/Userclass.dart';
import 'package:provider/provider.dart';
import './locprovider.dart';
class ChatScreen extends StatefulWidget {
  final String postid;
  ChatScreen(this.postid);
  @override
  _ChatScreenState createState() => _ChatScreenState(postid);
}

class _ChatScreenState extends State<ChatScreen> {
  bool isloading;
  String imageURL;
  User u;
  final String postid;
  List<dynamic> listMessage;
  File _image;
  DocumentSnapshot d;
  TextEditingController text=new TextEditingController();
  final ScrollController list=new ScrollController();
  _ChatScreenState(this.postid);


  
  @override
  void initState()
  {
    super.initState();
  
   
    isloading=false;
    imageURL='';


  } 
  Future<void> getImage() async{
    var image;
    try{
    image=await ImagePicker.pickImage(source: ImageSource.camera,maxWidth:600);
  }
catch(e){
  print(e);
}
    if(image != null)
    {_image=image;
      
      setState(() {
        isloading=true;
      });
      upload();
    }
    else{
      print('what the fuck');
    }

  }  
 Future upload() async
  {
    String fileName=DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference refernce=FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploasTask=refernce.putFile(_image);
    StorageTaskSnapshot storageTaskSnapshot=await uploasTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((url) {
      imageURL=url;
      setState(() {
        isloading=false;
        sendMessage(imageURL,1);

      });

    },onError: (err) {
      setState(() {
        isloading=false;
      });
      print('failed');
    });
  }
   void sendMessage(String content,int type)
  {
    if(content.trim() != ''){
      text.clear();
    
    DocumentReference d1= Firestore.instance.collection('Registeration').document(postid).collection('messages').document(DateTime.now().toString());
   Firestore.instance.runTransaction((transaction) async{
      await transaction.set(d1,{
        'name':u.username,
        'id':u.userid,
        'timestamp':DateTime.now().millisecondsSinceEpoch.toString(),
        'content':content,
        'type' :type
      });
      list.animateTo(0.0, duration: Duration(milliseconds: 0), curve: Curves.easeOut);
      });
      }
      else{
        print('Nothing to send');

      }
    }
    Widget buildItem(int index,var message)
    {print(message);
      if(message['id']==u.userid)
      {
        return Row(children: <Widget>[
          message['type'] == 0 ?
          Container(child:Text(message['content'],
          style:TextStyle(color: Colors.blueAccent)),
          padding: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
          decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 10.0 : 5.0,right:10.0),
          ):
          Container(
            child:FlatButton(child: Material(child:
            Container(width: 100,
            height:200,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(
              Radius.circular(8),
            )
            ),
            child:Image.network(message['content'],fit:BoxFit.cover),

            
            ),
             
            ),onPressed: () {print('Prssesd');},
           ),
           margin:EdgeInsets.only(bottom:isLastMessageRight(index)?20:10,right:10)
          )
           
        ],
        mainAxisAlignment: MainAxisAlignment.end,);
      }
      if(message['id'] != u.userid)
      {
        return Container(child: Column(children: <Widget>[
          Row(children: <Widget>[
            isLastMessageLeft(index)?
            Material(child: Container(height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Icon(Icons.account_circle,color:Colors.grey),),
            ):
            Container(width:35.0),
            message['type'] == 0 ?
          Container(child:Text('${message['name']}:\n${message['content']}',
          style:TextStyle(color: Colors.brown)),
          padding: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
          width:200,
          decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(bottom: isLastMessageLeft(index) ? 10.0 : 5.0,right:10.0),
          ):
          Container(
            child:FlatButton(child: Material(child:
            Container(width: 100,
            height:200,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(
              Radius.circular(8),
            )
            ),
            child:Image.network(message['content'],fit:BoxFit.cover,),

            
            ),
             
            ),onPressed: () {print('Presesd');},
           ),
           margin:EdgeInsets.only(bottom:isLastMessageLeft(index)?20:10,left:10)
          )
          ],),
          isLastMessageLeft(index)
          ? Container(child: Text(message['id'],style: TextStyle(color: Colors.grey,
          fontSize: 12.0),
          ),
          margin:EdgeInsets.only(left:50,top:5.0,bottom:5.0)):Container()
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom:10),
        );
      }
    }
    bool isLastMessageRight(int i)
    {
      if((i > 0 && listMessage != null && listMessage[i-1]['id']!=u.userid) || i==0)
      {
        return true;
      }
      else
      return false;

    }
    bool isLastMessageLeft(int i)
    {
      if((i > 0 && listMessage != null && listMessage[i-1]['id']=='rithik') || i==0)
      {
        return true;
      }
      else
      return false;

    }


  @override
  Widget build(BuildContext context) {
    final placedata=Provider.of<Places>(context,listen: true);
    u=placedata.u;
    return Stack(
      children: <Widget>[
        Column(children: <Widget>[
          buildListMessage(),
          buildInput(),
        ],),
        buildLoading(),
      ],
    );
      
   
  }
   Widget buildLoading()
  {
    return Positioned(child: isloading ?
    Container(child: Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
    ),
    color: Colors.white.withOpacity(0.8),
    ):
    Container()
    );
  }
    Widget buildInput()
  {
    return Container(child:Row(children: <Widget>[
      Material(child:Container(
        margin: EdgeInsets.symmetric(horizontal:1.0),
        child:IconButton(icon: Icon(Icons.image),
        onPressed: () => getImage(),
        color:Colors.red)),
        color: Colors.white,),
        Flexible(
          child:Container(child: TextField(style: TextStyle(color:Colors.black38,fontSize: 15),
          controller: text,
          decoration: InputDecoration.collapsed(
            hintText:AppTranslations.of(context).text("message_indicator")
            ,hintStyle:TextStyle(color:Colors.grey)
          ),
          ),
          )
        ),
        Material(child: Container(
          margin:EdgeInsets.symmetric(horizontal:8),
          child:new IconButton(icon:
          new Icon(Icons.send),
          onPressed: () => sendMessage(text.text,0),)
        ),
        color:Colors.white
        )

    ],),
    width: double.infinity,
    height:50,
    decoration:BoxDecoration(border: new Border(top:new BorderSide(color:Colors.grey,width: 0.5)
    ),color: Colors.white)
    );
  }
  Widget buildListMessage()
  {print(listMessage.toString());
     return Flexible(child: StreamBuilder(stream: Firestore.instance.collection('Registeration').document(postid).collection('messages').limit(20).orderBy('timestamp',descending:true)
    .snapshots(),
    builder:(context,snapshot) {
      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator(),);
      }
      else
      {
        listMessage=snapshot.data.documents;
        return ListView.builder(
          padding:EdgeInsets.all(10),
          itemBuilder:(context,index)=> buildItem(index,snapshot.data.documents[index]),
          itemCount:snapshot.data.documents.length,
          reverse:true,
          controller:list
        );
      }
  }
     ));
  }
}
  