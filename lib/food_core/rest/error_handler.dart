import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static Logger _logger = Logger();

  static ErrorResponseModel of(Object object) {
    String errorMessage;
    int statusCode;
    Map<String, dynamic> data;

    switch (object.runtimeType) {
      case DioError:
        DioError dioError = (object as DioError);
        final response = dioError.response;
        if (response != null) {
          statusCode = response.statusCode;
          try {
            data = response.data;
          } catch (e) {}
          _logger.e("Error : $statusCode -> ${response.data}");
          errorMessage = "${response.data}";
          break;
        }

        var error = dioError.error;
        if (error != null && error is Exception) {
          Exception exception = error;
          _logger.e("Error : $exception");
          errorMessage = "$exception";
          break;
        }

        _logger.e("Error : $dioError");
        errorMessage = "$dioError";
        break;
      default:
        _logger.e("Error : $object");
        errorMessage = "$object";
        break;
    }
    return ErrorResponseModel(statusCode, errorMessage, data);
  }
}
