import 'dart:async';

import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/model/product_details_model.dart';
import 'package:food_core/food_core/repositories/product_details_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/product_details/product_details_state.dart';

abstract class ProductDetailsPresenter {
  Stream<ProductDetailsState> getProductStreamController();

  ProductDetailsModel getProductDetailsModel();

  String getErrorMessage();

  dispose();
}

class BaseProductDetailsPresenter implements ProductDetailsPresenter {
  ProductDetailsRepository _pDetailsRepository = ProductDetailsRepository();

  final StreamController<ProductDetailsState> _pDetailsStreamController =
      StreamController();

  ProductDetailsModel _pDetails;

  ErrorResponseModel _errorResponse;

  BaseProductDetailsPresenter(productId) {
    fetchProductDetails(productId);
  }

  @override
  Stream<ProductDetailsState> getProductStreamController() {
    return _pDetailsStreamController.stream;
  }

  @override
  ProductDetailsModel getProductDetailsModel() {
    return _pDetails;
  }

  @override
  dispose() {
    _pDetailsStreamController.close();
    _pDetailsRepository.dispose();
  }

  void fetchProductDetails(productId) async {
    try {
      var response = await _pDetailsRepository.fetchProductDetails(productId);
      this._pDetails = response.productDetailsModel;

      _pDetailsStreamController.add(ProductDetailsState.SUCCESS);
    } catch (e) {
      handleError(e);
    }
  }

  void handleError(e) {
    if (_isDisposed()) return;
    this._errorResponse = ErrorHandler.of(e);
    _pDetailsStreamController.add(ProductDetailsState.ERROR);
  }

  bool _isDisposed() => _pDetailsStreamController.isClosed;

  @override
  String getErrorMessage() {
    var responseData = _errorResponse.responseData;
    if (responseData != null) {
      return ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      return _errorResponse.errorMessage;
    }
  }
}
