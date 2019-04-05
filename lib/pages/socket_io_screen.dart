import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';

class SocketIoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SocketIoScreenState();
}

class SocketIoScreenState extends State<SocketIoScreen> {
  TextEditingController _textEditingController = new TextEditingController();
  List<ChatModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll(dummyData);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('چت'),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(color: Colors.black12),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                  child: new Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: new ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: new BoxDecoration(color: Colors.green),
                        child: new Row(
                          children: <Widget>[
                            new Text(_messages[index].message)
                          ],
                        ),
                      );
                    }),
              )),
              new Container(
                decoration: new BoxDecoration(color: Colors.white),
                child: new Row(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.insert_emoticon),
                        onPressed: () {}),
                    new Expanded(
                        child: new TextField(
                      controller: _textEditingController,
                      decoration: new InputDecoration(
                          hintText: 'تایپ کنید...', border: InputBorder.none),
                    )),
                    new IconButton(icon: new Icon(Icons.send), onPressed: () {})
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
