import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('تنظیمات'),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.language),
              title: new Text("نتخاب زبان"),
              onTap: () {
                Navigator.pushNamed(context, '/settings/select_language');
              },
            )
          ],
        ));
  }
}
