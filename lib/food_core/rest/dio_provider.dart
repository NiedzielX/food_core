import 'package:dio/dio.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';
import 'package:food_core/food_core/service/local.dart';

class DioProvider {
  static Future<Dio> get({HttpClientAdapter mockAdapter}) async {
    String token = await Local().getToken();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "token $token";
    dio.options.responseType = ResponseType.json;
    dio.httpClientAdapter = mockAdapter ?? MockAdapter();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
