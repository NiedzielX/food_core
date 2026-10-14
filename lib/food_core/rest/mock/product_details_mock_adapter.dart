import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/product.dart';
import 'package:food_core/food_core/model/product_details_model.dart';
import 'package:food_core/food_core/model/product_details_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class ProductDetailsMockAdapter extends MockAdapter {
  var _productIngredients = [
    ProductIngredient(name: "grys kukurydziany (99,9%)"),
    ProductIngredient(name: "cukier"),
    ProductIngredient(name: "sól"),
    ProductIngredient(
        name: "glukoza"),
    ProductIngredient(name: "cukier brązowy"),
    ProductIngredient(name: "syrop cukru inwertowanego"),
    ProductIngredient(name: "melasa cukru trzcinowego"),
    ProductIngredient(name: "kwas pantotenowy (B5)"),
    ProductIngredient(name: "witamina B6"),
    ProductIngredient(name: "ryboflawina (B2)"),
    ProductIngredient(name: "tiamina (B1)"),
    ProductIngredient(name: "aromat naturalny"),
  ];

  var _productIngredients2 = [
    ProductIngredient(name: "Płatki owsiane")
  ];

  var _alternatives = [
    Product(
        id: 5,
        moreSugar: false,
        title: "Płatki owsiane bezglutenowe",
        image:
        "https://bezgluten.pl/sklep/2484-large_default/platki-owsiane-produkt-naturalnie-bezglutenowy.jpg",
        brand: "BEZGLUTENOWE",
        quantity: 300,
        unit: "g"),
  ];

  var _alternatives2 = [
    Product(
        id: 1,
        moreSugar: false,
        title: "Corn Flakes",
        image:
        "https://static.openfoodfacts.org/images/products/590/002/001/9592/front_pl.3.400.jpg",
        brand: "NESTLÉ",
        quantity: 300,
        unit: "g"),
  ];

  var _nutritionalValues = [
    ProductNutritionalValue(name: "Tłuszcz : 1,7 g\n(w tym: kwasy nasycone: 0,6 g)"),
    ProductNutritionalValue(name: "Węglowodany : 75g"),
    ProductNutritionalValue(name: "Błonnik : 8,7 g"),
    ProductNutritionalValue(name: "Białko : 8,3 g"),
  ];

  var _nutritionalValues2 = [
    ProductNutritionalValue(name: "Tłuszcz : 4,5 g\n(w tym kwasy nasycone: 0,7 g)"),
    ProductNutritionalValue(name: "Węglowodany : 74g\n(w tym cukry: 0,7 g)"),
    ProductNutritionalValue(name: "Białko : 12 g"),
    ProductNutritionalValue(name: "Sól : 0 g"),
  ];


  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));



    var productDetails = ProductDetailsModel(
      id:1,
        title: "Corn Flakes",
        brand: "NESTLÉ ",
        image:
            "https://static.openfoodfacts.org/images/products/590/002/001/9592/front_pl.3.400.jpg",
        weight: "200g",
        description:
            "Fakty o płatkach Nestlé Nesquik: - Pełne ziarno - nasz składnik nr 1 - Źródło błonnika - Bez oleju palmowego - Bez sztucznych aromatów Płatki Nesquik to źródło żelaza. Żelazo przyczynia się do prawidłowego rozwoju funkcji poznawczych u dzieci. Wspieraj rozwój swojego dziecka. Pamiętaj, że bardzo ważny jest zrównoważony sposób żywienia i zdrowych tryb życia.",
        ingredients: _productIngredients,
        nutritionalValues:_nutritionalValues,
        alternatives: _alternatives,
        isFavorite: false);

    var productDetails2 = ProductDetailsModel(
        id:5,
        title: "Płatki owsiane bezglutenowe",
        brand: "BEZGLUTENOWE ",
        image:
        "https://bezgluten.pl/sklep/2484-large_default/platki-owsiane-produkt-naturalnie-bezglutenowy.jpg",
        weight: "300g",
        description:
        "Różnica pomiędzy płatkami owsianymi, a błyskawicznymi polega na sposobie produkcji. Są one przygotowywane z ziaren owsa, które są następnie krojone i łamane. W przeciwieństwie do płatków błyskawicznych zachowują więcej wartości odżywczych. Płatki owsiane bezglutenowe są doskonałym źródłem białka, aminokwasów oraz witaminy E. Zawierają także zdrowe dla naszego organizmu nienasycone kwasy tłuszczowe oraz rozpuszczalny błonnik tzw. Beta-glukany , który skutecznie obniżają poziom cholesterolu, przeciwdziałając cukrzycy  typu 2 i chorobom nowotworowym.Popularnym daniem na bazie płatków jest owsianka. To nic innego, jak płatki owsiane na mleku. Najczęściej przygotowuje się ją z użyciem mleka krowiego, ale możliwe jest także zastosowanie mleka kokosowego lub sojowego. Wariancji przygotowania owsianki jest wiele, jednak najważniejsze jest to, że cały proces jest zazwyczaj bardzo łatwy i szybki. Aby takie śniadanie było jeszcze smaczniejsze warto urozmaicić posiłek porcją ulubionych owoców, miodem czy kakao. Jedząc płatki owsiane na śniadanie dostarczamy sobie wielu cennych składników oraz energii na dobry początek dnia.",
        ingredients: _productIngredients2,
        nutritionalValues:_nutritionalValues2,
        alternatives: _alternatives2,
        isFavorite: false);
    
    int id = int.parse(options.path.replaceAll("/product_details/", ""));
    var productDetailsResponseModel = ProductDetailsResponseModel();
    productDetailsResponseModel.productDetailsModel =  id == 5 ? productDetails2 : productDetails;
    String response = jsonEncode(productDetailsResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
