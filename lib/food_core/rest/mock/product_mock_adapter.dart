import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/product_list_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/products_all_mock_adapter.dart';

class ProductMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var products = await ProductAllMockAdapter.getProducts();

    var responseModel = ProductListResponseModel();
    responseModel.exclusive = products;
    responseModel.food = products;
    responseModel.bestsell = products;

    String response = jsonEncode(responseModel);

    //String response = jsonEncode(ErrorResponseDataModel(message: "Twoja sesja wygasła"));

    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
