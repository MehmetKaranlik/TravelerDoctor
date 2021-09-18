// To parse this JSON data, do
//
//     final locationInformation = locationInformationFromJson(jsonString);

import 'dart:convert';

LocationInformation locationInformationFromJson(String str) =>
    LocationInformation.fromJson(json.decode(str));

class LocationInformation {
  LocationInformation({
    required this.batchcomplete,
    required this.query,
  });

  String batchcomplete;
  Query query;

  factory LocationInformation.fromJson(Map<String, dynamic> json) {
    return LocationInformation(
      batchcomplete: json["batchcomplete"] as String,
      query: Query.fromJson(json["query"] as Map<String, dynamic>),
    );
  }
}

class Query {
  List<Geosearch> geosearch;
  Query({
    required this.geosearch,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        geosearch: List<Geosearch>.from(
          json["geosearch"].map(
            (x) => Geosearch.fromJson(x),
          ),
        ),
      );
}

class Geosearch {
  int pageid;
  int ns;
  String title;
  double lat;
  double lon;
  double dist;
  String primary;

  Geosearch({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.lat,
    required this.lon,
    required this.dist,
    required this.primary,
  });

  factory Geosearch.fromJson(Map<String, dynamic> json) {
    return Geosearch(
      pageid: json["pageid"] as int,
      ns: json["ns"] as int,
      title: json["title"] as String,
      lat: json["lat"].toDouble() as double,
      lon: json["lon"].toDouble() as double,
      dist: json["dist"].toDouble() as double,
      primary: json["primary"] as String,
    );
  }
}
