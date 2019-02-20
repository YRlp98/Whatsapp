import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class SecondMapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SecondMapScreenState();
}

class SecondMapScreenState extends State<SecondMapScreen> {
  MapController _mapController = new MapController();
  String _accessToken =
      'pk.eyJ1IjoieXJscDk4IiwiYSI6ImNqc2Q5dG81bDA5b2Q0NnFvcXlybWFvdG0ifQ.JpCWDyk-k80JhRJqmIBGBA';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('MapBox'),
      ),
      body: new FlutterMap(
        options: new MapOptions(
            center: new LatLng(35.715298, 51.404343),
            zoom: 15,
            onTap: (LatLng point) {
              print(point);
            }),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token=${_accessToken}",
            additionalOptions: {
              'accessToken': _accessToken,
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(markers: [
            new Marker(
                height: 40,
                width: 40,
                point: new LatLng(35.715298, 51.404343),
                builder: (context) {
                  return new Container(
                    child: new FlutterLogo(),
                  );
                })
          ])
        ],
        mapController: _mapController,
      ),
    );
  }
}
