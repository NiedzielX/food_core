import 'dart:async';

import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/model/product.dart';
import 'package:food_core/food_core/repositories/product_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/base/base_presenter.dart';
import 'package:food_core/food_core/ui/product_list/product_list_stream.dart';

abstract class ProductListPresenter extends BasePresenter {
  String getProductListError();

  List<Product> getProductList();

  Stream getProductListStream();

  void fetchProductList();
}

class BaseProductListPresenter extends ProductListPresenter {
  final StreamController _pListStreamController =
      StreamController<ProductListStream>();

  final ProductRepository _productRepository = ProductRepository();

  ErrorResponseModel _pListErrorResponseModel;

  List<Product> _productList;

  @override
  dispose() {
    super.dispose();
    _pListStreamController.close();
    _productRepository.dispose();
  }

  @override
  Stream getProductListStream() {
    return _pListStreamController.stream;
  }

  @override
  void fetchProductList() async {
    try {
      _pListStreamController.add(ProductListStream.LOADING);
      var response = await _productRepository.fetchAllProducts();
      this._productList = response.products;

      _pListStreamController.add(ProductListStream.COMPLETE);
    } catch (e) {
      handleProductListError(e);
    }
  }

  void handleProductListError(e) {
    if (isDisposed) return;
    _pListErrorResponseModel = ErrorHandler.of(e);
    _pListStreamController.add(ProductListStream.ERROR);
  }

  @override
  String getProductListError() {
    try {
      var responseData = _pListErrorResponseModel?.responseData;
      return ErrorResponseDataModel.fromJson(responseData).message ?? "";
    } catch (e) {
      return _pListErrorResponseModel?.errorMessage ?? "";
    }
  }

  @override
  List<Product> getProductList() {
    return _productList;
  }
}
