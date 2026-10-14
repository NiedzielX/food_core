import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/scan_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class ScanMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 200));
    var responseModel = ScanResponseModel();
    responseModel.id = 1;
    String response = jsonEncode(responseModel);

    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}