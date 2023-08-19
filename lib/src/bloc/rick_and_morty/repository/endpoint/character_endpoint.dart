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
