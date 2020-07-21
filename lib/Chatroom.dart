import 'package:flutter/material.dart';
import 'package:maps/Application.dart';
import 'package:maps/ChatScreen.dart';
class GroupChat extends StatefulWidget {
  final String postid;
  GroupChat(this.postid);
  @override
  _GroupChatState createState() => _GroupChatState(postid);
}

class _GroupChatState extends State<GroupChat> {
  final String postid;
  _GroupChatState(this.postid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text(AppTranslations.of(context).text("Group_chat")),),
      body:ChatScreen(postid)
      
    );
  }
}