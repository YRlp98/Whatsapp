import 'dart:async';

import 'package:flutter/material.dart';
import 'camera_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  startTime() {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    Navigator.of(context).pushReplacementNamed('login_screen');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
//    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xff075e54),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/whatsapp_start_icon.png'))),
                ),
                Padding(padding: const EdgeInsets.only(top: 8)),
                Text(
                  'واتس اپ',
                  style: TextStyle(
                      fontFamily: 'Vazir',
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(),
                ))
          ],
        ));
  }

//  void checkLogin() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    print(preferences.getString('user.api_token', userData['api_token']));
//  }
}
