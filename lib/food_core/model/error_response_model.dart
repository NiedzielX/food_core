class ErrorResponseModel {
  int statusCode;
  String errorMessage;
  Map<String, dynamic> responseData;

  ErrorResponseModel(this.statusCode, this.errorMessage, this.responseData);
}
