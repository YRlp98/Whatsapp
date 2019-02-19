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
  String error;

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

      error = null;
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied!';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - Please ask the user to enable it from the app setting';
      }

      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
