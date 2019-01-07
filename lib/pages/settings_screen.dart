import 'package:flutter/material.dart';
import 'camera_screen.dart';

//class SettingsScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Directionality(
//        textDirection: TextDirection.rtl,
//        child: Scaffold(
//            appBar: AppBar(
//              title: Text('تنظیمات'),
//            ),
//            body: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  'تنظیمات نرم افزار',
//                  style: TextStyle(fontSize: 20.0),
//                ),
//                RaisedButton(
//                  onPressed: () => Navigator.pop(context),
//                  child: Text('بازگشت'),
//                )
//              ],
//            )));
//  }
//}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text('ایجاد چت'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ایجاد چت جدید',
                  style: TextStyle(fontSize: 20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('بازگشت'),
                    )
                  ],
                )
              ],
            )));
  }
}
