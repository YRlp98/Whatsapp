import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  CameraPosition _position =
      new CameraPosition(target: LatLng(35.715298, 51.404343), zoom: 5);
  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
//  TODO: Sample
//    return Padding(
//      padding: EdgeInsets.all(15.0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          Center(
//            child: SizedBox(
//              width: 400.0,
//              height: 600.0,
//              child: new GoogleMap(
//                onMapCreated: _onMapCreated,
//                initialCameraPosition: CameraPosition(
//                  target: LatLng(35.715298, 	51.404343),
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
    return new Scaffold(
      body: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapType: _currentMapType,
//            TODO: set _position!
              initialCameraPosition: _position),
          new Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 16),
            child: new Align(
              alignment: Alignment.bottomLeft,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FloatingActionButton(
                    onPressed: () {
                      _onMapTypeButtonPressed;
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.map,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                  new SizedBox(height: 16),
                  new FloatingActionButton(
                    onPressed: () {},
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
  }

  void _onMapTypeButtonPressed() {
    if (_currentMapType == MapType.normal) {
      _currentMapType = MapType.satellite;
    } else {
      _currentMapType = MapType.normal;
    }
  }
}
