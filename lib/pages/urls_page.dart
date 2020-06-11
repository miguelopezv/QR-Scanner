import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';

import '../bloc/scans_bloc.dart';
import '../utils/utils.dart' as utils;

class UrlsPage extends StatelessWidget {
  final _scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data.length == 0) {
          return Center(
            child: Text('No data'),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) => Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) =>
                      _scansBloc.deleteScan(snapshot.data[i].id),
                  child: ListTile(
                    onTap: () => utils.openScan(context, snapshot.data[i]),
                    leading: Icon(
                      Icons.cloud_queue,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(snapshot.data[i].value),
                    subtitle: Text('ID: ${snapshot.data[i].id}'),
                    trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ),
                ));
      },
    );
  }
}
