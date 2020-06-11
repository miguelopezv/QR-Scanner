import 'dart:async';

import './validator.dart';
import '../providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _scansBloc = new ScansBloc._();

  factory ScansBloc() {
    return _scansBloc;
  }

  ScansBloc._() {
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamGeo =>
      _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp =>
      _scansController.stream.transform(validateHttp);

  dispose() {
    _scansController?.close();
  }

  // TODO: move to another file
  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAll());
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.insertOne(scan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteOne(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }
}
