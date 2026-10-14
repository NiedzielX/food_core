import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/product_details_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/product_details_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class ProductDetailsRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<ProductDetailsResponseModel> fetchProductDetails(int id) async {
    Dio dio = await DioProvider.get(mockAdapter: ProductDetailsMockAdapter());
    return RestClient(dio).fetchProductDetails(_cancelToken, id);
  }

  dispose() {
    _cancelToken.cancel();
  }
}
