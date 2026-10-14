import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/favorite_product_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/favorite_product_add_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/favorite_product_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';
import 'package:retrofit/retrofit.dart';

class FavoritesProductsRepository {
  CancelToken _cancelToken;

  Future<FavoriteProductResponseModel> fetchFavoritesProducts(
      String searchValue) async {
    _cancelToken = CancelToken();
    Dio dio =
        await DioProvider.get(mockAdapter: FavoritesProductsMockAdapter());
    return RestClient(dio).fetchFavoritesProducts(_cancelToken, searchValue);
  }

  Future<HttpResponse> addFavoriteProduct(int productId) async {
    _cancelToken = CancelToken();
    Dio dio =
        await DioProvider.get(mockAdapter: FavoriteProductAddMockAdapter());
    return RestClient(dio).addFavoriteProduct(_cancelToken, productId);
  }

  Future<HttpResponse> removeFavoriteProduct(int productId) async {
    _cancelToken = CancelToken();
    Dio dio =
        await DioProvider.get(mockAdapter: FavoriteProductAddMockAdapter());
    return RestClient(dio).removeFavoriteProduct(_cancelToken, productId);
  }

  dispose() {
    if (_cancelToken?.isCancelled == false) _cancelToken.cancel();
  }
}
