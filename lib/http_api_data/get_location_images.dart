// To parse this JSON data, do
//
//     final locationImages = locationImagesFromJson(jsonString);

import 'dart:convert';

LocationImages locationImagesFromJson(String str) =>
    LocationImages.fromJson(json.decode(str));

class LocationImages {
  LocationImages({
    required this.batchcomplete,
    required this.query,
  });

  bool batchcomplete;
  Query query;

  factory LocationImages.fromJson(Map<String, dynamic> json) => LocationImages(
        batchcomplete: json["batchcomplete"],
        query: Query.fromJson(json["query"]),
      );
}

class Query {
  Query({
    required this.pages,
  });

  List<Page> pages;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );
}

class Page {
  Page({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.original,
  });

  int pageid;
  int ns;
  String title;
  Original original;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
        original: json["original"] == null
            ? Original(
                source:
                    "https://tigres.com.tr/wp-content/uploads/2016/11/orionthemes-placeholder-image-1.png",
                width: 200,
                height: 300)
            : Original.fromJson(json["original"]),
      );
}

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
