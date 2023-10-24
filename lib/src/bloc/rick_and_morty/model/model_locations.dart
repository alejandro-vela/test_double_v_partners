import 'dart:convert';

import 'model_characters.dart';

LocationsModel locationsFromJson(String str) =>
    LocationsModel.fromJson(json.decode(str));

String locationsToJson(LocationsModel data) => json.encode(data.toJson());

class LocationsModel {
  LocationsModel({
    required this.info,
    required this.results,
  });

  factory LocationsModel.fromJson(Map<String, dynamic> json) => LocationsModel(
        info: Info.fromJson(json['info']),
        results:
            List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
      );
  Info info;
  List<Result> results;

  Map<String, dynamic> toJson() => {
        'info': info.toJson(),
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        dimension: json['dimension'],
        residents: List<String>.from(json['residents'].map((x) => x)),
        url: json['url'],
        created: DateTime.parse(json['created']),
      );
  int id;
  String name;
  String type;
  String dimension;
  List<String> residents;
  String url;
  DateTime created;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'dimension': dimension,
        'residents': List<dynamic>.from(residents.map((x) => x)),
        'url': url,
        'created': created.toIso8601String(),
      };
}
