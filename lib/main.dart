import 'package:flutter/material.dart';
import 'chatpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatBot(),
    );
  }
}

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'COVBOT',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Image(
              image: AssetImage('image/COVBOT-coverImage.jpeg'),
            ),
          ),
        ),
        backgroundColor: Colors.white54,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatPage()));
          },
          child: Text(
            'chat',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
