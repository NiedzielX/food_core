import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/scan_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/scan_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class ScanRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<ScanResponseModel> fetchScan(String code) async {
    Dio dio = await DioProvider.get(mockAdapter: ScanMockAdapter());
    return RestClient(dio).fetchScan(_cancelToken, code);
  }

  dispose() {
    _cancelToken.cancel();
  }
}
