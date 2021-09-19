// To parse this JSON data, do
//
//     final locationDataFinal = locationDataFinalFromJson(jsonString);

import 'dart:convert';

LocationDataFinal locationDataFinalFromJson(String str) =>
    LocationDataFinal.fromJson(json.decode(str));

class LocationDataFinal {
  LocationDataFinal({
    required this.batchcomplete,
    required this.query,
  });

  String batchcomplete;
  Query query;

  factory LocationDataFinal.fromJson(Map<String, dynamic> json) =>
      LocationDataFinal(
        batchcomplete: json["batchcomplete"],
        query: Query.fromJson(json["query"]),
      );
}

class Query {
  Query({
    required this.pages,
  });

  Map<String, Page> pages;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        pages: Map.from(json["pages"])
            .map((k, v) => MapEntry<String, Page>(k, Page.fromJson(v))),
      );
}

class Page {
  Page({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.index,
    required this.coordinates,
    required this.original,
    required this.description,
    required this.descriptionsource,
    required this.extract,
  });

  int pageid;
  int ns;
  String title;
  int index;
  List<Coordinate> coordinates;
  Original original;
  String description;
  String descriptionsource;
  String extract;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"] as String,
        index: json["index"],
        coordinates: List<Coordinate>.from(
            json["coordinates"].map((x) => Coordinate.fromJson(x))),
        original: json["original"] == null
            ? Original(
                source:
                    "https://tigres.com.tr/wp-content/uploads/2016/11/orionthemes-placeholder-image-1.png",
                width: 300,
                height: 200)
            : Original.fromJson(json["original"]),
        description: json["description"] == null ? " " : json["description"],
        descriptionsource:
            json["descriptionsource"] == null ? " " : json["descriptionsource"],
        extract: json["extract"],
      );
}

class Coordinate {
  Coordinate({
    required this.lat,
    required this.lon,
    required this.primary,
    required this.globe,
  });

  double lat;
  double lon;
  String primary;
  Globe globe;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        primary: json["primary"],
        globe: globeValues.map![json["globe"]]!,
      );
}

enum Globe { EARTH }

final globeValues = EnumValues({"earth": Globe.EARTH});

class Original {
  Original({
    required this.source,
    required this.width,
    required this.height,
  });

  String source;
  int width;
  int height;

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        source: json["source"],
        width: json["width"],
        height: json["height"],
      );
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);
}
