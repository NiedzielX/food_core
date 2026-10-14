import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/favorite_product_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/products_all_mock_adapter.dart';

class FavoritesProductsMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var favoriteProductResponseModel = FavoriteProductResponseModel();
    favoriteProductResponseModel.favoritesProducts =
        await ProductAllMockAdapter.getProducts();

    String response = jsonEncode(favoriteProductResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
