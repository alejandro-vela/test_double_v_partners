import '../../../../global_locator.dart';
import '../../../api/api_repository.dart';
import 'endpoint/character_endpoint.dart';

abstract class CharacterRepository {
  Future<Map<String, dynamic>> getCharacters(int page);
  Future<Map<String, dynamic>> getLocations(int page);
  Future<Map<String, dynamic>> getResident(String id);
  Future<Map<String, dynamic>> getEpisode(int id);
}

class CharacterRepositoryDefault extends CharacterRepository {
  final _api = global<APIRepository>();
  @override
  Future<Map<String, dynamic>> getCharacters(int page) async {
    final endpoint = CharactersEndpoint(page: page);
    final response = await _api.request(endpoint: endpoint);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getLocations(int page) async {
    final endpoint = LocationEndpoint(page: page);
    final response = await _api.request(endpoint: endpoint);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getResident(String id) async {
    final endpoint = CharacterEndpoint(id: id);
    final response = await _api.request(endpoint: endpoint);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getEpisode(int id) async {
    final endpoint = EpisodeEndpoint(page: id);
    final response = await _api.request(endpoint: endpoint);
    return response;
  }
}
