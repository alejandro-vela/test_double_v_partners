import 'dart:convert';

import 'model_characters.dart';

EpisodesModel episodesFromJson(String str) =>
    EpisodesModel.fromJson(json.decode(str));

String episodesToJson(EpisodesModel data) => json.encode(data.toJson());

class EpisodesModel {
  EpisodesModel({
    required this.info,
    required this.results,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => EpisodesModel(
        info: Info.fromJson(json['info']),
        results: List<ResultEpisodes>.from(
            json['results'].map((x) => ResultEpisodes.fromJson(x))),
      );
  Info info;
  List<ResultEpisodes> results;

  Map<String, dynamic> toJson() => {
        'info': info.toJson(),
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultEpisodes {
  ResultEpisodes({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory ResultEpisodes.fromJson(Map<String, dynamic> json) => ResultEpisodes(
        id: json['id'],
        name: json['name'],
        airDate: json['air_date'],
        episode: json['episode'],
        characters: List<String>.from(json['characters'].map((x) => x)),
        url: json['url'],
        created: DateTime.parse(json['created']),
      );
  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;
  DateTime created;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'air_date': airDate,
        'episode': episode,
        'characters': List<dynamic>.from(characters.map((x) => x)),
        'url': url,
        'created': created.toIso8601String(),
      };
}
