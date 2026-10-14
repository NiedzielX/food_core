import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/recovery_password_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class RecoveryPasswordRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<RecoveryPasswordResponseModel> recoveryPassword(String email) async {
    Dio dio = await DioProvider.get();
    return RestClient(dio).recoveryPassword(_cancelToken, email);
  }

  dispose() {
    _cancelToken.cancel();
  }
}
