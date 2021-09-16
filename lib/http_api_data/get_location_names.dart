// To parse this JSON data, do
//
//     final locationInformation = locationInformationFromJson(jsonString);

import 'dart:convert';

var jsonString;
final locationInformation = locationInformationFromJson(jsonString);

LocationInformation locationInformationFromJson(String str) =>
    LocationInformation.fromJson(json.decode(str));

class LocationInformation {
  LocationInformation({
    required this.batchcomplete,
    required this.query,
  });

  String batchcomplete;
  Query query;

  factory LocationInformation.fromJson(Map<String, dynamic> json) =>
      LocationInformation(
        batchcomplete: json["batchcomplete"],
        query: Query.fromJson(json["query"]),
      );
}

class Query {
  Query({
    required this.geosearch,
  });

  List<Geosearch> geosearch;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        geosearch: List<Geosearch>.from(
            json["geosearch"].map((x) => Geosearch.fromJson(x))),
      );
}

class Geosearch {
  Geosearch({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.lat,
    required this.lon,
    required this.dist,
    required this.primary,
  });

  int pageid;
  int ns;
  String title;
  double lat;
  double lon;
  double dist;
  String primary;

  factory Geosearch.fromJson(Map<String, dynamic> json) => Geosearch(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        dist: json["dist"].toDouble(),
        primary: json["primary"],
      );

  Map<String, dynamic> toJson() => {
        "pageid": pageid,
        "ns": ns,
        "title": title,
        "lat": lat,
        "lon": lon,
        "dist": dist,
        "primary": primary,
      };
}
