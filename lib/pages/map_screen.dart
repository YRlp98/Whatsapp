import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

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
            initialCameraPosition: CameraPosition(
              target: LatLng(35.715298, 51.404343),
            ),
          ),
          new RaisedButton(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  const CameraPosition(target: LatLng(51.5074, 0.1278),
                  zoom: 8
                  )));
            },
            child: new Text('Go to Iran '),
          ),
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
}
