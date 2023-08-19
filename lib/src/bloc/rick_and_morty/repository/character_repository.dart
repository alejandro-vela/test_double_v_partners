import '../../../../global_locator.dart';
import '../../../api/api_repository.dart';
import 'endpoint/character_endpoint.dart';

abstract class CharacterRepository {
  Future<Map<String, dynamic>> getCharacters(int page);
}

class CharacterRepositoryDefault extends CharacterRepository {
  final _api = global<APIRepository>();
  @override
  Future<Map<String, dynamic>> getCharacters(int page) async {
    final endpoint = CharactersEndpoint(page: page);
    final response = await _api.request(endpoint: endpoint);
    return response;
  }
}
