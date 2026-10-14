import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/product.dart';
import 'package:food_core/food_core/model/product_all_response_model.dart';
import 'package:food_core/food_core/repositories/interview_repository.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class ProductAllMockAdapter extends MockAdapter {
  static var _products = [
    Product(
        id: 1,
        moreSugar: true,
        title: "Lait - Łaciate",
        image:
            "https://static.openfoodfacts.org/images/products/590/082/000/0042/front_pl.36.400.jpg",
        brand: "Łaciate",
        quantity: 1,
        unit: "l"),
    Product(
        id: 2,
        moreSugar: false,
        title: "Serek wiejski naturalny",
        image:
            "https://static.openfoodfacts.org/images/products/590/053/100/0010/front_pl.18.400.jpg",
        brand: "Piątnica",
        quantity: 200,
        unit: "g"),
    Product(
        id: 3,
        moreSugar: false,
        title: "Ser królewski",
        image:
            "https://static.openfoodfacts.org/images/products/590/175/300/0628/front_pl.4.400.jpg",
        brand: "Sierpc",
        quantity: 135,
        unit: "g"),
    Product(
        id: 4,
        moreSugar: false,
        title: "Corn Flakes",
        image:
            "https://static.openfoodfacts.org/images/products/590/002/001/9592/front_pl.3.400.jpg",
        brand: "Nestle",
        quantity: 200,
        unit: "g"),
    Product(
        id: 5,
        moreSugar: false,
        title: "Płatki owsiane bezglutenowe",
        image:
            "https://bezgluten.pl/sklep/2484-large_default/platki-owsiane-produkt-naturalnie-bezglutenowy.jpg",
        brand: "BEZGLUTENOWE",
        quantity: 300,
        unit: "g"),
    Product(
        id: 6,
        moreSugar: false,
        title: "Napój owsiany naturalny",
        image:
            "https://www.delikatesyznatury.pl/environment/cache/images/500_500_productGfx_12271/Napoj-Owsiany-Naturalny-1L---Alpro.jpg",
        brand: "ALPRO",
        quantity: 1,
        unit: "l"),
    Product(
        id: 7,
        moreSugar: false,
        title: "Napój gazowany o smaku Cola",
        image:
            "https://static.openfoodfacts.org/images/products/544/900/000/0996/front_pl.364.400.jpg",
        brand: "Coca-Cola",
        quantity: 330,
        unit: "ml"),
    Product(
        id: 8,
        moreSugar: false,
        title: "Filety z makreli w sosie pomidorowym",
        image:
            "https://static.openfoodfacts.org/images/products/20096410/front_pl.4.400.jpg",
        brand: "Nautica",
        quantity: 170,
        unit: "g"),
    Product(
        id: 9,
        moreSugar: false,
        title: "Filety z makreli w sosie pomidorowym",
        image:
            "https://www.carrefour.pl/images/product/350x350/king-oscar-filety-z-makreli-w-sosie-pomidorowym-170-g-b1cq5o.jpg",
        brand: "King Oscar",
        quantity: 170,
        unit: "g"),
    Product(
        id: 10,
        moreSugar: false,
        title: "Piwo jasne",
        image:
            "https://static.openfoodfacts.org/images/products/590/049/000/0182/front_pl.14.400.jpg",
        brand: "LECH",
        quantity: 500,
        unit: "ml"),
  ];

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var responseModel = ProductsAllResponseModel();
    responseModel.products = await getProducts();

    String response = jsonEncode(responseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }

  static Future<List<Product>> getProducts() async {
    InterviewRepository interviewRepository = InterviewRepository();

    List<Product> products = _products;

    List<int> selectedAnswer = await interviewRepository.getSelectedAnswers(3);
    if (selectedAnswer.isNotEmpty) {
      var answer = selectedAnswer[0];
      switch (answer) {
        case 18:
          products = products
              .where((product) =>
                  product.id != 1 && product.id != 3 && product.id != 4)
              .toList();
          break;
        case 19:
          products = products
              .where((product) => product.id != 1 && product.id != 3)
              .toList();
          break;
        case 20:
          products = products.where((product) => product.id != 10).toList();
          break;
        case 21:
          products = products
              .where((product) =>
                  product.id != 5 && product.id != 8 && product.id != 10)
              .toList();
          break;
        case 22:
          products = products
              .where((product) =>
                  product.id != 1 &&
                  product.id != 2 &&
                  product.id != 3 &&
                  product.id != 4 &&
                  product.id != 10)
              .toList();
          break;
      }
    }
    return products;
  }
}
