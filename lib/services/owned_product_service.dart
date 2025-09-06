import '../models/my_product_detail.dart';
import '../models/owned_product_data.dart';
import '../utils/constants.dart';
import 'api_client.dart';

class OwnedProductService {
  final ApiClient _apiClient = ApiClient();

  Future<List<OwnedProductData>> getOwnedProductListFromApi() async {
    try {
      final response = await _apiClient.get(AppConstants.getOwnedProductsEndpoint);

      if (response is List) {
        return response.map((json) => OwnedProductData.fromJson(json)).toList();
      } else {
        throw Exception('Expected List but got ${response.runtimeType}');
      }
    } catch (e) {
      throw Exception('Failed to load owned products: $e');
    }
  }

  Future<void> addOwnedProduct(MyProductDetail product) async {
    try {
      await _apiClient.post(
        AppConstants.addOwnedProductsEndpoint,
        product.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to add owned product: $e');
    }
  }
}
