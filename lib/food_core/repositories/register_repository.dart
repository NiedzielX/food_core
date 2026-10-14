import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/register_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class RegisterRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<RegisterResponseModel> register(String email, String password, String name) async {
    Dio dio = await DioProvider.get();
    return RestClient(dio).register(_cancelToken, email, name, password);
  }

  dispose() {
    _cancelToken.cancel();
  }
}