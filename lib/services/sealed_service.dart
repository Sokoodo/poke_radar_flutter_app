import '../models/sealed_detail.dart';
import '../utils/constants.dart';
import 'api_client.dart';

class SealedService {
  final ApiClient _apiClient = ApiClient();

  Future<List<SealedDetail>> getSealedListFromApi() async {
    try {
      final response = await _apiClient.get(AppConstants.sealedPokemonEndpoint);

      if (response is List) {
        return response.map((json) => SealedDetail.fromJson(json)).toList();
      } else {
        throw Exception('Expected List but got ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to load sealed products: $e');
    }
  }
}
