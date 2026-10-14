import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/category_model.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/repositories/category_scroller_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/dashboard/home/views/category_scroller/category_scroller_state.dart';

abstract class CategoryScrollerPresenter {
  Stream<CategoryScrollerState> getCategoryStream();

  Future<void> fetchCategories();

  List<CategoryModel> getCategories();

  String getCategoryErrorMessage();

  ValueNotifier<int> getSelectedCategoryNotifier();

  dispose();

  void selectCategory(int categoryId);
}

class BaseCategoryScrollerPresenter extends CategoryScrollerPresenter {
  CategoryScrollerRepository _categoryScrollerRepository =
      CategoryScrollerRepository();

  final StreamController _categoryStreamController =
      StreamController<CategoryScrollerState>();

  final ValueNotifier<int> _selectedCategoryNotifier = ValueNotifier(-1);

  ErrorResponseModel _categoryErrorResponseModel;

  List<CategoryModel> _categoryList;

  bool _isDisposed = false;

  @override
  dispose() {
    _categoryScrollerRepository.dispose();
    _categoryStreamController.close();
    _isDisposed = true;
  }

  @override
  Future<void> fetchCategories() async {
    try {
      _categoryStreamController.add(CategoryScrollerState.LOADING);
      var response = await _categoryScrollerRepository.fetchCategories();
      this._categoryList = response.categoryList;

      _categoryStreamController.add(CategoryScrollerState.COMPLETED);
    } catch (e) {
      handleCategoryError(e);
    }
  }

  @override
  List<CategoryModel> getCategories() {
    return _categoryList;
  }

  void handleCategoryError(e) {
    if (_isDisposed) return;
    _categoryErrorResponseModel = ErrorHandler.of(e);
    _categoryStreamController.add(CategoryScrollerState.ERROR);
  }

  @override
  String getCategoryErrorMessage() {
    var responseData = _categoryErrorResponseModel.responseData;
    var errorMessage;
    if (responseData != null) {
      errorMessage = ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      errorMessage = _categoryErrorResponseModel.errorMessage;
    }
    return errorMessage;
  }

  @override
  Stream<CategoryScrollerState> getCategoryStream() {
    return _categoryStreamController.stream;
  }

  @override
  ValueNotifier<int> getSelectedCategoryNotifier() {
    return _selectedCategoryNotifier;
  }

  @override
  void selectCategory(int selectedId) {
    var currentSelectedCategory = _selectedCategoryNotifier.value;
    if (currentSelectedCategory == selectedId) {
      selectedId = -1;
    }
    _selectedCategoryNotifier.value = selectedId;
  }
}
