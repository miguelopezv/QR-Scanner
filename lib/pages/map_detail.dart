import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';

import '../models/scan_model.dart';

class MapDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel _scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {},
          )
        ],
      ),
      body: _renderMap(_scan),
    );
  }

  Widget _renderMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,
      ),
      layers: [_createMap()],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoibWlndWVsb3BlenYiLCJhIjoiY2tiYXp6aWdtMHRjbTJ3bzB0cm8wNXhpdiJ9.L8-ONFQLttNpkqg3dhQwnw',
          'id': 'mapbox.streets'
        });
  }
}
