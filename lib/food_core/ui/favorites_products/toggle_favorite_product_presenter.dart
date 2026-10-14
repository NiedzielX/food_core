import 'dart:async';

import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/repositories/favorites_products_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/favorites_products/toggle_favorite_product_state.dart';

abstract class ToggleFavoriteProductPresenter {
  Stream<ToggleFavoriteProductState> getStream();

  Future<void> toggleFavoriteProduct();

  String getErrorMessage();

  bool isFavorite();

  dispose();
}

class BaseToggleFavoritesProductsPresenter
    extends ToggleFavoriteProductPresenter {
  StreamController<ToggleFavoriteProductState> _streamController =
      StreamController();

  final FavoritesProductsRepository _fpRepository =
      FavoritesProductsRepository();

  BaseToggleFavoritesProductsPresenter(this._isFavorite, this._productId);

  final int _productId;
  bool _isFavorite;

  ErrorResponseModel _errorResponse;

  @override
  dispose() {
    _streamController.close();
    _fpRepository.dispose();
  }

  @override
  Stream<ToggleFavoriteProductState> getStream() {
    return _streamController.stream;
  }

  void handleError(e) {
    if (_isDisposed()) return;
    this._errorResponse = ErrorHandler.of(e);
    _streamController.add(ToggleFavoriteProductState.ERROR);
  }

  bool _isDisposed() => _streamController.isClosed;

  @override
  String getErrorMessage() {
    var responseData = _errorResponse?.responseData;
    if (responseData != null) {
      return ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      return _errorResponse?.errorMessage;
    }
  }

  @override
  toggleFavoriteProduct() async {
    _streamController.add(ToggleFavoriteProductState.SAVING);
    try {
      if (_isFavorite) {
        await _fpRepository.removeFavoriteProduct(_productId);
      } else {
        await _fpRepository.addFavoriteProduct(_productId);
      }
      _isFavorite = !_isFavorite;
      _streamController.add(ToggleFavoriteProductState.IDLE);
    } catch (e) {
      handleError(e);
    }
  }

  @override
  bool isFavorite() {
    return _isFavorite;
  }
}
