import '../models/singles_detail.dart';
import '../utils/constants.dart';
import 'api_client.dart';

class SinglesService {
  final ApiClient _apiClient = ApiClient();

  Future<List<SinglesDetail>> getSinglesListFromApi() async {
    try {
      final response = await _apiClient.get(AppConstants.singlesPokemonEndpoint);

      if (response is List) {
        return response.map((json) => SinglesDetail.fromJson(json)).toList();
      } else {
        throw Exception('Expected List but got ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to load singles: $e');
    }
  }
}
