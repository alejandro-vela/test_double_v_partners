import '../../../../api/endpoint.dart';

class CharactersEndpoint extends Endpoint {
  CharactersEndpoint({
    required this.page,
  });

  final int page;

  @override
  Method get method => Method.get;

  @override
  String get path => 'api/character';

  @override
  Map<String, dynamic> get queryParameters => {
        'page': page.toString(),
      };
}

class CharacterEndpoint extends Endpoint {
  CharacterEndpoint({
    required this.id,
  });

  final String id;

  @override
  Method get method => Method.get;

  @override
  String get path => 'api/character/$id';
}

class LocationEndpoint extends Endpoint {
  LocationEndpoint({
    required this.page,
  });

  final int page;

  @override
  Method get method => Method.get;

  @override
  String get path => 'api/location';

  @override
  Map<String, dynamic> get queryParameters => {
        'page': page.toString(),
      };
}

class EpisodeEndpoint extends Endpoint {
  EpisodeEndpoint({
    required this.page,
  });

  final int page;

  @override
  Method get method => Method.get;

  @override
  String get path => 'api/episode';

  @override
  Map<String, dynamic> get queryParameters => {
        'page': page.toString(),
      };
}
