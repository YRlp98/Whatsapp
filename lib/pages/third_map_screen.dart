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
  List<Marker> _markers = <Marker>[];

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
              setState(() {
                _markers.add(new Marker(
                    width: 40,
                    height: 40,
                    point: point,
                    builder: (context) {
                      return new Container(
                        child: new Image.asset(
                            'assets/images/whatsapp_start_icon.png'),
                      );
                    }));
              });
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
          new MarkerLayerOptions(markers: _markers)
        ],
        mapController: _mapController,
      ),
    );
  }
}
