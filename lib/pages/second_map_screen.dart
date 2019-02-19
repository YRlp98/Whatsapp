import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MapLocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MapLocationScreenState();
}

class MapLocationScreenState extends State<MapLocationScreen> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  Location _location = new Location();
  bool _permission = false;
  String ereor;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  initPlatformState() async {
    Map<String, double> location;

    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
