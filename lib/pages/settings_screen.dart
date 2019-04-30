import 'package:flutter/material.dart';
import 'package:whatsapp/all_translation.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print(allTranslations.currentLanguage);

    return new Scaffold(
        appBar: AppBar(
          title: Text('تنظیمات'),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.language),
              title: new Text("انتخاب زبان"),
              onTap: () {
                Navigator.pushNamed(context, '/settings/select_language');
              },
            )
          ],
        ));
  }
}
