import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';

import '../models/scan_model.dart';

class MapDetailPage extends StatefulWidget {
  @override
  _MapDetailPageState createState() => _MapDetailPageState();
}

class _MapDetailPageState extends State<MapDetailPage> {
  final MapController mapCtrl = new MapController();
  String mapType = 'streets';
  int typeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ScanModel _scan = ModalRoute.of(context).settings.arguments;
    final double _zoom = 12;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapCtrl.move(_scan.getLatLng(), _zoom);
            },
          )
        ],
      ),
      body: _renderMap(_scan, _zoom),
      floatingActionButton: _renderTypeButton(context),
    );
  }

  Widget _renderMap(ScanModel scan, double zoom) {
    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: zoom,
      ),
      layers: [
        _createMap(),
        _createMarkpoint(scan),
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
          'id': 'mapbox.$mapType'
        });
  }

  _createMarkpoint(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 120,
          height: 120,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 45,
                  color: Theme.of(context).primaryColor,
                ),
              )),
    ]);
  }

  Widget _renderTypeButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        // TODO: Update flutter_map when this functionality has been fixed
        setState(() {
          List<String> types = [
            'streets',
            'dark',
            'light',
            'outdoors',
            'satellite'
          ];
          typeIndex == 4 ? typeIndex = 0 : typeIndex++;

          mapType = types[typeIndex];
        });
      },
    );
  }
}
