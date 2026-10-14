import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/model/user_edit_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class UserEditMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));
    var responseModel = UserEditResponseModel();
    var user = User();
    user.id = 99;
    user.email = "test@test.pl";
    user.name = "Jan Kowalski";
    user.avatar = "https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png";
    responseModel.user = user;
    responseModel.message = "Edycja przebiegła pomyślnie";
    responseModel.success = true;

    String response = jsonEncode(responseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}