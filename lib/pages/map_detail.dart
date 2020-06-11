import 'package:flutter/material.dart';
import 'package:qr_scanner/providers/db_provider.dart';

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
      body: Center(
        child: Text(_scan.value),
      ),
    );
  }
}
