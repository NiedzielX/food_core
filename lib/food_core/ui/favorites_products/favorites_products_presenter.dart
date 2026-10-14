import 'dart:async';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/model/favorite_product_model.dart';
import 'package:food_core/food_core/model/favorite_product_response_model.dart';
import 'package:food_core/food_core/model/product.dart';
import 'package:food_core/food_core/repositories/favorites_products_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/favorites_products/favorites_products_state.dart';

abstract class FavoritesProductsPresenter {
  Stream<FavoritesProductsState> getFavoritesProductsStream();

  fetchFavoritesProductsList({searchValue});

  List<FavoriteProductModel> getFavoritesProductsList();

  String getErrorMessage();

  dispose();
}

class BaseFavoritesProductsPresenter extends FavoritesProductsPresenter {
  StreamController<FavoritesProductsState> _streamController =
      StreamController.broadcast();

  final FavoritesProductsRepository _fpRepository =
      FavoritesProductsRepository();

  static const String DEFAULT_SEARCH_VALUE = "";

  List<FavoriteProductModel> _favoriteProductList;

  ErrorResponseModel _errorResponse;

  @override
  dispose() {
    _streamController.close();
    _fpRepository.dispose();
  }

  @override
  Stream<FavoritesProductsState> getFavoritesProductsStream() {
    return _streamController.stream;
  }

  @override
  fetchFavoritesProductsList({searchValue = DEFAULT_SEARCH_VALUE}) async {
    _streamController.add(FavoritesProductsState.LOADING);
    _fpRepository.dispose();

    try {
      var response = await _fpRepository.fetchFavoritesProducts(searchValue);
      this._favoriteProductList =
          await _mapFavoriteProducts(response, searchValue);

      _streamController.add(FavoritesProductsState.SUCCESS);
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.CANCEL) {
        return;
      }
      handleError(e);
    }
  }

  //TODO remove where
  Future<List<FavoriteProductModel>> _mapFavoriteProducts(
      FavoriteProductResponseModel response, searchValue) async {
    return response.favoritesProducts
        .map((Product product) => FavoriteProductModel(
              productId: product.id,
              productName: product.title,
              image: product.image,
              weight: product.quantity,
              weightUnit: product.unit,
              brand: product.brand
            ))
        .toList()
        .where((favoriteProduct) =>
            favoriteProduct.productName.toLowerCase().contains(searchValue) ||
            favoriteProduct.brand.toLowerCase().contains(searchValue))
        .toList();
  }

  void handleError(e) {
    if (_isDisposed()) return;
    this._favoriteProductList = [];
    this._errorResponse = ErrorHandler.of(e);
    _streamController.add(FavoritesProductsState.ERROR);
  }

  bool _isDisposed() => _streamController.isClosed;

  @override
  List<FavoriteProductModel> getFavoritesProductsList() {
    return this._favoriteProductList;
  }

  @override
  String getErrorMessage() {
    var responseData = _errorResponse?.responseData;
    if (responseData != null) {
      return ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      return _errorResponse?.errorMessage;
    }
  }
}
