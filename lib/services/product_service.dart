import '../models/product_detail.dart';
import '../utils/constants.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();

  Future<ProductDetail> getProductDetailsFromApi(String idUrl) async {
    try {
      final response = await _apiClient.get(
        AppConstants.productDetailEndpoint,
        queryParams: {'id_url': idUrl},
      );

      return ProductDetail.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }
}
