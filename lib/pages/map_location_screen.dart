import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MapLocationScreenState();
}

class MapLocationScreenState extends State<MapLocationScreen> {
  GoogleMapController mapController;
  CameraPosition _position =
      new CameraPosition(target: LatLng(35.715298, 51.404343), zoom: 5);
  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new GoogleMap(
              onMapCreated: _onMapCreated,
              trackCameraPosition: true,
              myLocationEnabled: true,
              mapType: _currentMapType,
              initialCameraPosition: _position),
          new Row(
            children: <Widget>[
              Expanded(
                child: new Container(
                    height: 50,
                    decoration: new BoxDecoration(color: Colors.black45),
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          'موقعیت:  ${_position.target.longitude.toStringAsFixed(3)}, ${_position.target.latitude.toStringAsFixed(3)}',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              )
            ],
          ),
          new Padding(
            padding: const EdgeInsets.only(bottom: 66, left: 16),
            child: new Align(
              alignment: Alignment.bottomLeft,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.map,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                  new SizedBox(height: 16),
                  new FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.add_location,
                      size: 36,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
//    setState(() {
//      mapController = controller;
//    });
    mapController = controller;
    mapController.addListener(_onMapChanged);
  }

  void _onMapChanged() {
    setState(() {
      _position = mapController.cameraPosition;
    });
  }

  void _onMapTypeButtonPressed() {
    if (_currentMapType == MapType.normal) {
      _currentMapType = MapType.satellite;
    } else {
      _currentMapType = MapType.normal;
    }
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(MarkerOptions(
        position: LatLng(mapController.cameraPosition.target.latitude,
            mapController.cameraPosition.target.longitude),
        draggable: true,
        infoWindowText: InfoWindowText('Josi Map', 'This is Josi Map!'),
        icon: BitmapDescriptor.defaultMarker));
  }
}
