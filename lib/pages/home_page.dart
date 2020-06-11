import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

import './maps_page.dart';
import './urls_page.dart';

import '../models/scan_model.dart';
import '../bloc/scans_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => _scansBloc.deleteAllScans,
          )
        ],
      ),
      body: _renderPage(_currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('URLs'))
      ],
    );
  }

  Widget _renderPage(int page) {
    switch (page) {
      case 0:
        return MapsPage();
      case 1:
        return UrlsPage();
      default:
        return MapsPage();
    }
  }

  _scanQR() async {
    // http://reddit.com
    // geo:40.65967463655211,-74.22704115351566
    // dynamic futureString = '';
    dynamic futureString = 'http://reddit.com';

    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      _scansBloc.addScan(scan);
    }

    print('Future String: ${futureString.rawContent}');
  }
}
