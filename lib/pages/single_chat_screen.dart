import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'package:whatsapp/models/chat_model.dart';

class SingleChatScreen extends StatelessWidget {
  final ChatModel data;

  SingleChatScreen({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(this.data.avatarUrl),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    this.data.name,
                    style: TextStyle(fontSize: 17.0),
                  )
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'صفحه چت ' + this.data.name,
                  style: TextStyle(fontSize: 20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CameraScreen()));
                      },
                      child: Text('صفحه دوم'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context, 'سلام ${this.data.name}');
                      },
                      child: Text('بازگشت'),
                    )
                  ],
                )
              ],
            )));
  }
}
