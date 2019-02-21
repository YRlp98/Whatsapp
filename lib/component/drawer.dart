import 'package:flutter/material.dart';

Drawer buildDrawerLayout() {
  return new Drawer(
    child: new ListView(
      children: <Widget>[
        new DrawerHeader(
            child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: <Color>[
            const Color(0xff075e54),
            const Color(0xff05433c)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ))
      ],
    ),
  );
}
