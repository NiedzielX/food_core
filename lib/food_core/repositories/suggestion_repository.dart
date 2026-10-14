import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/suggestion_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/suggestion_favorite_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/suggestion_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class SuggestionRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<SuggestionResponseModel> fetchSuggestion(String phrase) async {
    Dio dio = await DioProvider.get(mockAdapter: SuggestionMockAdapter());
    return RestClient(dio).fetchSuggestion(_cancelToken, phrase);
  }

  Future<SuggestionResponseModel> fetchFavoriteSuggestion(String phrase) async {
    Dio dio = await DioProvider.get(mockAdapter: SuggestionFavoriteMockAdapter());
    return RestClient(dio).fetchSuggestion(_cancelToken, phrase);
  }

  dispose() {
    _cancelToken.cancel();
  }
}