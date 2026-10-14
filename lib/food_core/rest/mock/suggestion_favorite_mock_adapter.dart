import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/suggestion_model.dart';
import 'package:food_core/food_core/model/suggestion_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class SuggestionFavoriteMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var items = [
      SuggestionModel(value: "Płatki śniadaniowe Corn Flakes", brand: "Nestle"),
      SuggestionModel(value: "Mleko Łaciate", brand: "MlekPol"),
      SuggestionModel(value: "Napój owsiany naturalny", brand: "Alpro"),
    ];

    var responseModel = SuggestionResponseModel();
    responseModel.items = items;

    String response = jsonEncode(responseModel);

    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}