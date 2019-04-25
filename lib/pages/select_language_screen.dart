import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatelessWidget {
  SelectLanguageScreen() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('انتخاب زبان'),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("انگلیسی"),
              onTap: () {
                Navigator.pushNamed(context, '/settings/select_language');
              },
              trailing: new Icon(Icons.check),
            ),
            new ListTile(
              title: new Text("فارسی"),
              onTap: () {
                Navigator.pushNamed(context, '/settings/select_language');
              },
            ),
          ],
        ));
  }
}
