import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/category_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/category_scroller_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class CategoryScrollerRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<CategoryResponseModel> fetchCategories() async {
    var mockAdapter = CategoryScrollerMockAdapter();
    Dio dio = await DioProvider.get(mockAdapter: mockAdapter);
    return RestClient(dio).fetchCategories(_cancelToken);
  }

  dispose() {
    _cancelToken.cancel();
  }
}
