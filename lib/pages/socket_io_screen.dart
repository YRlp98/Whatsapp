import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class SocketIoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SocketIoScreenState();
}

class SocketIoScreenState extends State<SocketIoScreen> {
  TextEditingController _textEditingController = new TextEditingController();
  List<ChatModel> _messages = [];
  int _userId;
  SocketIO _socketIO;

  @override
  void initState() {
    super.initState();
//    _messages.addAll(dummyData);

    _userId = new Random().nextInt(1000);
    _socketIO = SocketIOManager().createSocketIO("http://192.198.1.7:3000", '/',
        socketStatusCallback: _socketIoStatus);
    _socketIO.init();
    _socketIO.subscribe('message', _onReceiveNewMessage);
    _socketIO.connect();
  }

  @override
  void dispose() {
    if (_socketIO != null) {
      _socketIO.destroy();
    }
    super.dispose();
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
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, top: 10),
                    child: new ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 10, left: 10),
                            decoration: new BoxDecoration(
                                color: _userId == _messages[index].id
                                    ? Colors.green
                                    : Colors.white),
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
                              hintText: 'تایپ کنید...',
                              border: InputBorder.none),
                        )),
                    new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: () {
                          String msg = _textEditingController.text;

                          if (_textEditingController.text.length > 0) {
                            setState(() {
//                            socket.io
                              _sendChatMessage(msg);
                              _messages
                                  .add(ChatModel(id: _userId, message: msg));
                              _textEditingController.text = '';
                            });
                          }
                        })
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _socketIoStatus(dynamic data) {
    print('Socket Status: ' + data);
  }

  void _sendChatMessage(String msg) {
    if (_socketIO != null) {
      Map<String, dynamic> jsonData = {'id': _userId, 'message': msg};
      _socketIO.sendMessage('send_message', json.encode(jsonData));
    }
  }

  _onReceiveNewMessage(dynamic message) {
    Map<String, dynamic> msg = json.decode(message);

    print(msg);
    setState(() {
      _messages.add(new ChatModel(
          id: msg['id'],
          message: msg['message']
      ));
    });
  }
}
