import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/login_response_model.dart';
import 'package:food_core/food_core/model/user_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class LoginRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<LoginResponseModel> login(String email, String password) async {
    Dio dio = await DioProvider.get();
    return RestClient(dio).login(_cancelToken, email, password);
  }

  Future<UserResponseModel> me(String token) async {
    Dio dio = await DioProvider.get();
    return RestClient(dio).me(_cancelToken, token);
  }

  dispose() {
    _cancelToken.cancel();
  }
}