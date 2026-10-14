import 'dart:async';
import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/login_response_model.dart';
import 'package:food_core/food_core/model/recovery_password_response_model.dart';
import 'package:food_core/food_core/model/register_response_model.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/model/user_response_model.dart';

class MockAdapter extends HttpClientAdapter {
  final DefaultHttpClientAdapter _adapter = DefaultHttpClientAdapter();
  final Map<String, List<String>> responseHeaders = {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  };

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    String path = options.path;
    switch (path) {
      case "/recovery_password":
        var status = 200;
        return ResponseBody.fromString(status == 400 ? _getRecoveryPasswordErrorResponse() : _getRecoveryPasswordResponse(), status,
            headers: responseHeaders);
      case "/login":
        return ResponseBody.fromString(_getLoginResponse(), 200,
            headers: responseHeaders);
      case "/me":
        return ResponseBody.fromString(_getUserResponse(), 200,
            headers: responseHeaders);
      case "/register":
        return ResponseBody.fromString(_getRegisterResponse(), 200,
            headers: responseHeaders);
      default:
        return ResponseBody.fromString("", 404);
    }
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }

  String _getRecoveryPasswordResponse() {
    var model = RecoveryPasswordResponseModel();
    model.message =
        "Na podany adress email został wysłany link do zmiany hasła";
    String json = jsonEncode(model);
    return json;
  }

  String _getRecoveryPasswordErrorResponse() {
    var model = ErrorResponseDataModel();
    model.message =
    "Twoja sesja wygasła";
    String json = jsonEncode(model);
    return json;
  }

  String _getLoginResponse() {
    var model = LoginResponseModel();
    model.message = "Udało się zalogować";
    model.token = "dsadewtewtewfewfewfew";

    String json = jsonEncode(model);
    return json;
  }

  String _getUserResponse() {
    var model = UserResponseModel();
    var user = User();
    user.id = 99;
    user.email = "test@test.pl";
    user.name = "Jan Kowalski";
    user.avatar = "https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png";
    model.user = user;
    String json = jsonEncode(model);
    return json;
  }

  String _getRegisterResponse() {
    var model = RegisterResponseModel();
    model.message = "Udało się zalogować";
    model.token = "dsadewtewtewfewfewfew";
    String json = jsonEncode(model);
    return json;
  }
}
