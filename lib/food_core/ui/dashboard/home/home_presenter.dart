import 'package:food_core/food_core/model/response.dart';
import 'package:food_core/food_core/repositories/product_repository.dart';
import 'package:food_core/food_core/repositories/suggestion_repository.dart';
import 'package:food_core/food_core/ui/dashboard/home/home_view.dart';

abstract class HomePresenter {
  set view(HomeView value);
  void resetParams();
  void getData();
  void dispose();
  Future<List> suggestion(String phrase);
}

class BasicHomePresenter implements HomePresenter {

  HomeView _view;
  ProductRepository _repository = ProductRepository();
  SuggestionRepository _suggestionRepository = SuggestionRepository();

  BasicHomePresenter() {
    getData();
  }

  @override
  set view(HomeView value) {
    _view = value;
  }

  getData() async {
    try {
      var response = await _repository.fetchHomeProduct();
      _view.setViewData(response.food, response.exclusive, response.bestsell);
    } catch (e) {
      _view.onError(Response.defaultErrorResponse);
    }
  }

  @override
  void resetParams() {}

  @override
  void dispose() {
    _repository.dispose();
    _suggestionRepository.dispose();
  }

  @override
  Future<List> suggestion(String phrase) async {
    try {
      var response = await _suggestionRepository.fetchSuggestion(phrase);
      return response.items;
    } catch (e) {
      return [];
    }
  }
}