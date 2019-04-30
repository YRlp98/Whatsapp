import 'package:flutter/material.dart';
import 'package:whatsapp/all_translation.dart';

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
                _changeLanguage(context, 'en');
              },
              trailing: checkLanguage('en'),
            ),
            new ListTile(
              title: new Text("فارسی"),
              onTap: () {
                _changeLanguage(context, 'fa');
              },
              trailing: checkLanguage('fa'),
            ),
          ],
        ));
  }

  _changeLanguage(BuildContext context, String lang) async {
    await allTranslations.setNewLanguage(lang);
    Navigator.pushReplacementNamed(context, '/home');
  }

  checkLanguage(String lang) {
    return allTranslations.currentLanguage == lang
        ? new Icon(Icons.check)
        : new SizedBox();
  }
}
