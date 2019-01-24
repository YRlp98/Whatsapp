import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'single_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
        itemCount: dummyDate.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Divider(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  _navigateAndDisplayContextMessage(context, dummyDate[index]);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(dummyDate[index].avatarUrl),
                    backgroundColor: Colors.grey,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        dummyDate[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dummyDate[index].time,
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      )
                    ],
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.only(top: 2.5),
                    child: Text(
                      dummyDate[index].message,
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

_navigateAndDisplayContextMessage(BuildContext context, ChatModel data) async {
  final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => SingleChatScreen(data: data)));
  Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
    result,
    style: TextStyle(fontFamily: 'Vazir'),
  )));
}
