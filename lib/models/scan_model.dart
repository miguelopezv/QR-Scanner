import 'dart:convert';

import 'package:latlong/latlong.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    this.type = this.value.contains('http') ? 'http' : 'geo';
  }

  int id;
  String type, value;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng getLatLng() {
    final coord = value.substring(4).split(',');
    final lat = double.parse(coord[0]);
    final lon = double.parse(coord[1]);

    return LatLng(lat, lon);
  }
}
