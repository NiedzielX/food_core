import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/user_delete_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class UserDeleteMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));
    var responseModel = UserDeleteResponseModel();
    responseModel.success = true;
    responseModel.message = "Profil został usunięty";
    String response = jsonEncode(responseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}