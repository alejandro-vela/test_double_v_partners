import '../../../../api/endpoint.dart';

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
