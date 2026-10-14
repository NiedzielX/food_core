import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/product_all_response_model.dart';
import 'package:food_core/food_core/model/product_list_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/product_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/products_all_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class ProductRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<ProductListResponseModel> fetchHomeProduct() async {
    Dio dio = await DioProvider.get(mockAdapter: ProductMockAdapter());
    return RestClient(dio).fetchProductHome(_cancelToken);
  }

  Future<ProductsAllResponseModel> fetchAllProducts() async {
    Dio dio = await DioProvider.get(mockAdapter: ProductAllMockAdapter());
    return RestClient(dio).fetchAllProducts(_cancelToken);
  }

  dispose() {
    _cancelToken.cancel();
  }
}
