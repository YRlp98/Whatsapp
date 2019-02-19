import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapLocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MapLocationScreenState();
}

class MapLocationScreenState extends State<MapLocationScreen> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  GoogleMapController _mapController;
  CameraPosition _position;

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

    setState(() {
      _startLocation = location;
      _position = new CameraPosition(
          target: LatLng(location['latitude'], location['longitude']),
          zoom: 18);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widget;
    var size = MediaQuery.of(context).size;

    widget.add(new SizedBox(
        width: size.width,
        height: 300,
        child: _position != null
            ? new GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: _position,
                trackCameraPosition: true,
                myLocationEnabled: true,
              )
            : new SizedBox()));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('User Location'),
      ),
      body: new Column(
        children: widget,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
