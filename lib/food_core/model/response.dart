import 'package:food_core/food_core/utils/strings.dart';

class Response<T> extends Object {

  static const String STATUS = "status";
  static const String MESSAGE = "message";
  static const String DATA = "data";

  static const int SUCCESS_CODE = 200;
  static const int NO_AUTH_CODE = 403;
  static const int NOT_FOUND_CODE = 500;

  static final Map<String, dynamic> defaultResponseJSON = {STATUS: SUCCESS_CODE, MESSAGE: "", DATA: []};
  static final Response defaultErrorResponse = Response(status: NOT_FOUND_CODE, message: Strings.apiError);

  int status;
  String message;
  T data;

  Response({this.status, this.message, this.data});

  factory Response.fromJson(Map<String, dynamic> parsedJson) {
    return Response(
        status: parsedJson[STATUS],
        message: parsedJson[MESSAGE]
    );
  }
}