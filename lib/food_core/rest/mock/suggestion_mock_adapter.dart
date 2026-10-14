import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/suggestion_model.dart';
import 'package:food_core/food_core/model/suggestion_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class SuggestionMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var items = [
      SuggestionModel(value: "Płatki śniadaniowe Corn Flakes", brand: "Nestle"),
      SuggestionModel(value: "Mleko Łaciate", brand: "MlekPol"),
      SuggestionModel(value: "Napój owsiany naturalny", brand: "Alpro"),
      SuggestionModel(value: "Serek wiejski", brand: "Piątnica"),
      SuggestionModel(value: "Napój gazowany Coca-Cola", brand: "Coca-Cola"),
      SuggestionModel(value: "Ser królewski", brand: "Sierpc"),
      SuggestionModel(value: "Filety z makreli w sosie pomidorowym", brand: "Nautica"),
      SuggestionModel(value: "Płatki owsiane bezglutenowe", brand: "Bg"),
      SuggestionModel(value: "Piwo jasne", brand: "LECH"),
      SuggestionModel(value: "Filety z makreli w sosie pomidorowym", brand: "King Oscar"),
    ];

    var responseModel = SuggestionResponseModel();
    responseModel.items = items;

    String response = jsonEncode(responseModel);

    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}