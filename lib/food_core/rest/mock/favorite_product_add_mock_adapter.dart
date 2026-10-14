import 'package:dio/dio.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class FavoriteProductAddMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));
    String response = "true";
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
