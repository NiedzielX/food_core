import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/category_model.dart';
import 'package:food_core/food_core/model/category_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class CategoryScrollerMockAdapter extends MockAdapter {
  var categories = [
    CategoryModel(1, "Dinner", "http://barniak.pl/mock/pizza.png"),
    CategoryModel(2, "Lunch", "http://barniak.pl/mock/lunch.png"),
    CategoryModel(3, "Breakfast", "http://barniak.pl/mock/croissant.png"),
    CategoryModel(4, "Dessert", "http://barniak.pl/mock/icecream.png")
  ];

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    var categoryResponseModel = CategoryResponseModel();
    categoryResponseModel.categoryList = categories;

    String response = jsonEncode(categoryResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
