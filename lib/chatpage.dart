import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map> message = List();

  void response(String query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/cov.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    setState(() {
      message.insert(0, {
        "data": 0,
        "message": response.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
  }

  void submit(String text) {
    response(text);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontrol = new TextEditingController();

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'COVBOT',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: ListView.builder(
                reverse: true,
                itemCount: message.length,
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => message[index]["data"] == 0
                    ? Text(message[index]["message"].toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                    : Text(message[index]["message"].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
              )),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: TextField(
                      controller: textcontrol,
                      decoration: InputDecoration.collapsed(
                        hintText: "Type your message here",
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          message.insert(
                              0, {"data": 1, "message": textcontrol.text});
                          response(textcontrol.text);
                          textcontrol.clear();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
