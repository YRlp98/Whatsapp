import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class SecondMapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SecondMapScreenState();
}

class SecondMapScreenState extends State<SecondMapScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Map'),
      ),
      body: new FlutterMap(options: null),
    );
  }
}
