import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/all_translation.dart';
import 'package:whatsapp/helper.dart';
import 'package:whatsapp/services/auth_services.dart';
import 'package:whatsapp/translations.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

//  startTime() {
//    var _duration = Duration(seconds: 2);
//    return Timer(_duration, navigationPageToLogin);
//  }

  navigationToLogin() {
    Navigator.of(context).pushReplacementNamed('/login_screen');
  }

  navigationToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
//    startTime();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff075e54),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 100,
                  height: 100,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage(
                              'assets/images/whatsapp_start_icon.png'))),
                ),
                Padding(padding: const EdgeInsets.only(top: 8)),
                new Text(allTranslations.text('title'),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
              ],
            ),
            new Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(),
                ))
          ],
        ));
  }

  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
//    await preferences.remove('user.api_token');
    String apiToken = preferences.getString('user.api_token');

//    if (apiToken == null) navigationToLogin();

    if (await checkConnectionInternet()) {
//      Check api Token
      await AuthService.checkApiToken(apiToken)
          ? navigationToHome()
          : navigationToLogin();
    } else {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(hours: 2),
          content: new GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
              checkLogin();
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Check internet connecton',
                    style: TextStyle(fontFamily: 'Vazir')),
                new Icon(Icons.signal_wifi_off, color: Colors.white)
              ],
            ),
          )));
    }
  }
}
